# -*- encoding : utf-8 -*-
require 'net/http'
require 'net/https'
require 'yajl'

module RegApi2
  class NetError < Exception
  end
  class ApiError < Exception
    attr_reader :description
    def initialize code,  description
      super code
      @description = description
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

    # Do actual call to REG.API using POST/JSON convention.
    # @param [Symbol] category
    # @param [Symbol] name
    # @param [Hash] opts
    # @return [Hash] Result answer field.
    def make_action category, name, opts = {}
      req = Net::HTTP::Post.new(
        category.nil? ? "#{API_URI.path}/#{name}" : "#{API_URI.path}/#{category}/#{name}"
      )

      # HACK: REG.API doesn't know about utf-8.
      io_encoding = 'utf8'  if !io_encoding || io_encoding == DEFAULT_IO_ENCODING
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
      req.set_form_data(form)
      res = http.request(req)
      raise NetError.new(res.body)  unless res.code == '200'
      json = Yajl::Parser.parse(res.body)
      raise ApiError.new(json['error_code'], json['error_text'])  if json['result'] == 'error'
      json['answer']
    end

    end
  end
