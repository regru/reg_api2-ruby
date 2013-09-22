# -*- encoding : utf-8 -*-
require 'net/http'
require 'net/https'
require 'yajl'

require 'reg_api2/util'

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

    # Default IO encoding
    DEFAULT_IO_ENCODING = 'utf-8'
    # Default lang.
    DEFAULT_LANG = 'en'
    # Default API contract for requests
    DEFAULT_REQUEST_CONTRACT = RegApi2::RequestContract::Default
    # Default API contract for results
    DEFAULT_RESULT_CONTRACT = RegApi2::ResultContract::Default

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
        http
      end
    end

    # Placeholder to inspect sent form
    # @param [String] path
    # @param [Hash] form
    # @return Doesn't matter
    def form_to_be_sent(path, form)
    end

    # Placeholder to inspect got response.
    # @param [Net::HTTPResponse] response
    # @return Doesn't matter
    def got_response(response)
    end

    # Gets {Class} by its name.
    # @param [Class] ancestor
    # @param [NilClass, Class, String] name
    # @param [Class] default_value
    # @return [Class] contract
    def get_contract ancestor, name, default_value
      return default_value  unless name
      return name  if name.kind_of?(Class)
      ancestor.const_get(RegApi2::Util.constantize name)
    end

    # Gets {RegApi2::RequestContract} by its name.
    # @param [NilClass, Class, String] name
    # @return [Class] {RegApi2::RequestContract}
    def get_request_contract_by_name name
      get_contract(RegApi2::RequestContract, name, DEFAULT_REQUEST_CONTRACT)
    end

    # Gets {RegApi2::ResultContract} by its name.
    # @param [NilClass, Class, String] name
    # @return [Class] {RegApi2::ResultContract}
    def get_result_contract_by_name name
      get_contract(RegApi2::ResultContract, name, DEFAULT_RESULT_CONTRACT)
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
      opts = get_request_contract_by_name(defopts[:request]).new(defopts).validate(opts)

      form = {
        'username' => username,
        'password' => password,
        'io_encoding' => io_encoding,
        'lang' => lang || DEFAULT_LANG,
        'output_format' => 'json',
        'input_format' => 'json',
        'show_input_params' => 0,
        'input_data' => Yajl::Encoder.encode(opts)
      }

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

      res_contract = get_result_contract_by_name(defopts[:result]).new(defopts)
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
