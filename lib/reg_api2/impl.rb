# -*- encoding : utf-8 -*-
require 'uri'
require 'net/http'
require 'net/https'
require 'yajl'

module RegApi2
  # Networking Error.
  # Raised when response doesn't meet HTTP 200 OK status.
  class NetError < IOError
  end

  # API Contract Error.
  # Raised when input parameters doesn't pass Ruby client tests.
  class ContractError < ArgumentError
    # @!attribute [r] fields
    # @return [Array<String>] Wrong fields. 
    attr_reader :fields

    def initialize message, fields = []
      super message
      fields = []  if fields.nil?
      fields = [ fields ]  unless fields.kind_of?(Array)
      @fields = fields
    end
  end

  # API Error from REG.API provider.
  # Please refer to {file:README.md#Common_error_codes common error codes}.
  class ApiError < StandardError
    # @!attribute [r] description
    # @return [String] Localized error description.
    attr_reader :description
    # @!attribute [r] params
    # @return [Hash] Optional error params.
    attr_reader :params

    def initialize code,  description, params
      super code
      @description = description
      @params = params ||  {}
    end

    # Extracts error arguments from specified json.
    # @param [Hash] json
    # @return [ApiError] Initialized error object.
    def self.from_json json
      new(
        json['error_code'],
        json['error_text'],
        json['error_params']
      )
    end
  end

  class << self
    # @!attribute [rw] username
    # @return [String] User name (`test` by default).
    attr_accessor :username
    # @!attribute [rw] password
    # @return [String] Password (`test` by default).
    attr_accessor :password
    # @!attribute [rw] io_encoding
    # @return [String] IO encoding (`utf-8` by default).
    attr_accessor :io_encoding
    # @!attribute [rw] lang
    # @return [String] Language (`en` by default).
    attr_accessor :lang
    # @!attribute [rw] ca_cert_path
    # @return [String] Path to certification authority certificate (nil by default).
    attr_accessor :ca_cert_path
    # @!attribute [rw] pem
    # @return [String] X.509 certificate (nil by default).
    attr_accessor :pem
    # @!attribute [rw] pem_password
    # @return [String] X.509 certificate password (nil by default).
    attr_accessor :pem_password
    # @!attribute [rw] dump_requests_to
    # @return [String,Symbol,Lambda] Where to dump outgoing API request (nil by default).
    #
    #    | Value | Dump to |
    #    | ----- | ------- |
    #    | nil | Nothing |
    #    | :stdout, "stdout" | $stdout |
    #    | :stderr, "stderr" | $stderr |
    #    | lambda | Calls this lambda with requested path and form hash |
    attr_accessor :dump_requests_to
    # @!attribute [rw] dump_responses_to
    # @return [String,Symbol,Lambda] Where to dump incoming API response (nil by default).
    #
    #    | Value | Dump to |
    #    | ----- | ------- |
    #    | nil | Nothing |
    #    | :stdout, "stdout" | $stdout |
    #    | :stderr, "stderr" | $stderr |
    #    | lambda | Calls this lambda with incoming parsed JSON data |
    attr_accessor :dump_responses_to

    private :dump_requests_to, :dump_responses_to

    # Dumps outgoing API requests to given `to` or code block.
    # @param [String,Symbol,Lambda] to Where to dump incoming API response (nil by default).
    #
    #    | Value | Dump to |
    #    | ----- | ------- |
    #    | nil | Nothing |
    #    | :stdout, "stdout" | $stdout |
    #    | :stderr, "stderr" | $stderr |
    #    | lambda | Calls this lambda with requested path and form hash |
    #
    # @param [Code] code_block Code block to be executed on every API request.
    # @yield [path, form] Request path and form to be sent.
    # @return [NilClass] nil
    # @example Dump outgoing API requests to code block
    #    RegApi2.dump_requests { |path, form| p path; p form }
    def dump_requests(to = nil, &code_block)
      if to.nil? && block_given?
        to = code_block
      end
      self.dump_requests_to = to
      nil
    end

    # Dumps incoming API responses to given `to` or code block.
    # @param [String,Symbol,Lambda] to Where to dump outgoing API response (nil by default).
    #
    #    | Value | Dump to |
    #    | ----- | ------- |
    #    | nil | Nothing |
    #    | :stdout, "stdout" | $stdout |
    #    | :stderr, "stderr" | $stderr |
    #    | lambda | Calls this lambda with incoming parsed JSON data |
    #
    # @param [Code] code_block Code block to be executed on every API response.
    # @yield [json] Response parsed JSON data to be handled.
    # @return [NilClass] nil
    # @example Dump incoming API responses to `$stdout`
    #    RegApi2.dump_responses :stdout
    def dump_responses(to = nil, &code_block)
      if to.nil? && block_given?
        to = code_block
      end
      self.dump_responses_to = to
      nil
    end

    # Default IO encoding
    DEFAULT_IO_ENCODING = 'utf-8'
    # Default lang.
    DEFAULT_LANG = 'en'

    # REG.API base URI
    API_URI = URI.parse("https://api.reg.ru/api/regru2")

    def apply_ca_cert_path(http)
      unless ca_cert_path.nil?
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        http.ca_file     = ca_cert_path
      else
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
    end

    def apply_pem(http)
      return  if pem.nil?
      http.cert = OpenSSL::X509::Certificate.new(pem)
      if pem_password
        raise ArgumentError, "The private key requires a password"  if pem_password.empty?
        http.key = OpenSSL::PKey::RSA.new(pem, pem_password)
      else
        http.key = OpenSSL::PKey::RSA.new(pem)
      end
    end

    private :apply_pem, :apply_ca_cert_path

    # Creates HTTPS handler.
    # @return [Net::HTTP] HTTPS handler.
    # @see #http
    def create_http
      _http = Net::HTTP.new(
        API_URI.host, 
        API_URI.port
      )
      _http.use_ssl = true
      apply_ca_cert_path(_http)
      apply_pem(_http)
      _http
    end

    # Creates or gets HTTPS handler.
    # @return [Net::HTTP] HTTPS handler.
    # @see #create_http
    # @see #clear_http
    def http
      @http ||= create_http
    end

    # Clears internal `http` singleton.
    # Also finishes any started HTTP session.
    # @return nil
    # @note For testing purposes.
    # @see #http
    def clear_http
      return nil  unless @http
      @http.finish  if @http.respond_to?(:started) && @http.started
      @http = nil
    end

    # Placeholder to inspect sent form
    # @param [String] path
    # @param [Hash] form
    # @return void
    def form_to_be_sent(path, form)
      case dump_requests_to
      when :stderr, "stderr"
        $stderr.puts "RegApi2.Request:\n#{path}\n#{form}"
      when :stdout, "stdout"
        $stdout.puts "RegApi2.Request:\n#{path}\n#{form}"
      when Proc
        dump_requests_to.call(path, form)
      when nil
        ;
      else
        raise ArgumentError.new( "Bad dump_requests_to field: #{dump_requests_to.inspect}" )
      end
      nil
    end

    # Placeholder to inspect got response.
    # @param [Net::HTTPResponse] response
    # @return void
    def got_response(response)
      case dump_responses_to
      when :stderr, "stderr"
        $stderr.puts "RegApi2.Response:\n#{response}"
      when :stdout, "stdout"
        $stdout.puts "RegApi2.Response:\n#{response}"
      when Proc
        dump_responses_to.call(response)
      when nil
        ;
      else
        raise ArgumentError.new( "Bad dump_responses_to field: #{dump_responses_to.inspect}" )
      end
      nil
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
      req_contract = RegApi2::RequestContract.new(defopts)
      opts = req_contract.validate(opts)

      form = {
        'username'          => username || 'test',
        'password'          => password || 'test',
        'io_encoding'       => io_encoding,
        'lang'              => lang || DEFAULT_LANG,
        'output_format'     => 'json',
        'input_format'      => 'json',
        'show_input_params' => 0,
        'input_data'        => Yajl::Encoder.encode(opts)
      }

      form
    end

    # Handles response
    # @param [Hash] defopts
    # @param [Net::HTTPResponse] res HTTP Response
    # @return [Object] Contracted response.
    # @raise [NetError]
    # @raise [ApiError]
    def handle_response(defopts, res)
      raise NetError.new(res.body)  unless res.code == '200'

      json = Yajl::Parser.parse(res.body)
      got_response(json)

      raise ApiError.from_json(json)  if json['result'] == 'error'

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

      handle_response(defopts, res)
    end

  end
end
