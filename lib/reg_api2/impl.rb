# -*- encoding : utf-8 -*-
require 'uri'
require 'net/http'
require 'net/https'
require 'yajl'

module RegApi2
  # Networking Error
  class NetError < Exception
  end

  # API Contract Error
  class ContractError < Exception
    # @!attribute [r] fields
    # Wrong fields.
    attr_reader :fields

    def initialize message, fields = []
      super message
      @fields = fields
    end
  end

  # API Error
  class ApiError < Exception
    # @!attribute [r] description
    # Localized error description.
    attr_reader :description
    # @!attribute [r] params
    # Optional error params.
    attr_reader :params

    def initialize code,  description, params
      super code
      @description = description
      @params = params
    end
  end

  class << self
    # @!attribute [rw] username
    # @return [String] User name.
    attr_accessor :username
    # @!attribute [rw] password
    # @return [String] Password.
    attr_accessor :password
    # @!attribute [rw] io_encoding
    # @return [String] IO encoding ('utf-8' by default).
    attr_accessor :io_encoding
    # @!attribute [rw] lang
    # @return [String] Language ('en' by default).
    attr_accessor :lang
    # @!attribute [rw] ca_cert_path
    # @return [String] Path to certificate (nil by default).
    attr_accessor :ca_cert_path
    # @!attribute [rw] pem
    # @return [String] PEM (nil by default).
    attr_accessor :pem
    # @!attribute [rw] pem_password
    # @return [String] PEM password (nil by default).
    attr_accessor :pem_password

    # Default IO encoding
    DEFAULT_IO_ENCODING = 'utf-8'
    # Default lang.
    DEFAULT_LANG = 'en'

    # REG.API base URI
    API_URI = URI.parse("https://api.reg.ru/api/regru2")

    # Creates or gets HTTPS handler.
    # @return [Net::HTTP] HTTPS handler.
    def http
      @http ||= begin
        http = Net::HTTP.new(
          API_URI.host, 
          API_URI.port
        )
        http.use_ssl = true
        unless ca_cert_path.nil?
          http.verify_mode = OpenSSL::SSL::VERIFY_PEER
          http.ca_file     = ca_cert_path
        else
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
        unless pem.nil?
          http.cert = OpenSSL::X509::Certificate.new(pem)
          if pem_password
            raise ArgumentError, "The private key requires a password"  if pem_password.empty?
            http.key = OpenSSL::PKey::RSA.new(pem, pem_password)
          else
            http.key = OpenSSL::PKey::RSA.new(pem)
          end
        end
        http
      end
    end

    # Placeholder to inspect sent form
    # @param [String] path
    # @param [Hash] form
    # @return void
    def form_to_be_sent(path, form)
    end

    # Placeholder to inspect got response.
    # @param [Net::HTTPResponse] response
    # @return void
    def got_response(response)
    end

    # Gets form data for POST request
    # @param [Hash] defopts
    # @param [Hash] opts
    # @return [Hash] Form data to be sent.
    # @raise [ContractError]
    def get_form_data(defopts, opts)
      # HACK: REG.API doesn't know about utf-8.
      io_encoding = 'utf8'  if !io_encoding || io_encoding == DEFAULT_IO_ENCODING
      opts = opts.to_hash  if opts.respond_to?(:to_hash)
      opts = RegApi2::RequestContract.new(defopts).validate(opts)

      form = {
        'io_encoding' => io_encoding,
        'lang' => lang || DEFAULT_LANG,
        'output_format' => 'json',
        'input_format' => 'json',
        'show_input_params' => 0,
        'input_data' => Yajl::Encoder.encode(opts)
      }

      form['username'] = username  if username
      form['password'] = password  if password

      form
    end

    # Handles response
    # @param [Hash] defopts
    # @param [Net::HTTPResponse] res HTTP Response
    # @return [Object] Contracted response.
    # @raise [NetError]
    # @raise [ApiError]
    # @raise [ContractError]
    def handle_response(defopts, res)
      raise NetError.new(res.body)  unless res.code == '200'

      json = Yajl::Parser.parse(res.body)
      raise ApiError.new(
        json['error_code'],
        json['error_text'],
        json['error_params']
      )  if json['result'] == 'error'

      res_contract = RegApi2::ResultContract.new(defopts)
      res_contract.handle_result(json)
    end

    # Do actual call to REG.API using POST/JSON convention.
    # @param [Symbol] category
    # @param [Symbol] name
    # @param [Hash] defopts
    # @param [Hash] opts
    # @return [Hash] Result answer field.
    # @raise [NetError]
    # @raise [ApiError]
    # @raise [ContractError]
    def make_action category, name, defopts, opts = {}
      req = Net::HTTP::Post.new(
        category.nil? ? "#{API_URI.path}/#{name}" : "#{API_URI.path}/#{category}/#{name}"
      )
      form = get_form_data(defopts, opts)
      form_to_be_sent(req.path, form)

      req.set_form_data(form)
      res = http.request(req)
      got_response(res)

      handle_response(defopts, res)
    end

  end
end
