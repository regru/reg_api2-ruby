# -*- encoding : utf-8 -*-

require 'reg_api2/action'

module RegApi2
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

    include RegApi2::Action
  end
end
