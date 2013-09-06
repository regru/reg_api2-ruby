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
    attr_accessor :user
    attr_accessor :password
    attr_accessor :io_encoding
    attr_accessor :lang

    io_encoding = 'utf-8'
    output_format = 'json'
    lang = 'en'

    API_URI = URI.parse("https://api.reg.ru/api/regru2")
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

    def make_action category, name, opts = {}
      req = Net::HTTP::Post.new(
        category.nil? ? "#{API_URI.path}/#{name}" : "#{API_URI.path}/#{category}/#{name}"
      )
      p req.path
      req['username'] = user
      req['password'] = password
      req['io_encoding'] = io_encoding
      req['lang'] = lang
      req['output_format'] = 'json'
      req['input_format'] = 'json'
      req['show_input_params'] = 0;
      req['input_data'] = Yajl::Encoder.encode(opts)
      res = http.request(req)
      raise NetError.new(res.body)  unless res.code == '200'
      json = Yajl::Parser.parse(res.body)
      raise ApiError.new(json['error_code'], json['error_text'])  if json['result'] == 'error'
      json
    end

  end
  end
