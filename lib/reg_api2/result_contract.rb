# -*- encoding : utf-8 -*-

require 'reg_api2/sym_hash'

module RegApi2
  # Contract for API results.
  # Waits for answer field and returns it only by default.
  # @see SymHash
  class ResultContract
    # Fields that will be converted to {Fixnum}.
    # @see #convert
    INT_FIELDS = %w[
      active_domains_cnt
      active_domains_get_ctrl_cnt
      domain_folders_cnt
      renew_domains_cnt
      renew_domains_get_ctrl_cnt
      undelegated_domains_cnt
      bill_id
      service_id
      server_id
      folder_id
      cpu_count
      cpu_core
      hdd_count
      ram_count
    ].freeze

    # Fields that will be converted to {Float}.
    # @see #convert
    FLOAT_FIELDS = %w[
      amount
      total_amount
      payment
      total_payment
      month_traf
      price_retail
    ].freeze

    # Fields that will be converted to {Boolean}.
    # @see #convert
    BOOL_FIELDS = %w[
      success
    ].freeze

    # Options of contract.
    # @return [Hash] Options hash.
    attr_reader :opts

    def initialize(opts = {})
      @opts = opts
    end

    # Extracts answer field and returns it wrapped by {#handle_answer}.
    # Result is unified using {SymHash.from}.
    # @param [Hash] result API result.
    # @return Reworked API answer field.
    # @see SymHash
    def handle_result(result)
      result = SymHash.from(result)
      handle_answer(result[:answer])
    end

    def convert_hash(answer)
      answer.each_pair do |key, value|
        case value
        when String
          if INT_FIELDS.include?(key.to_s)
            answer[key] = value.to_i
          elsif FLOAT_FIELDS.include?(key.to_s)
            answer[key] = value.to_f
          elsif BOOL_FIELDS.include?(key.to_s)
            answer[key] = value.to_i.nonzero? ? true : false
          end
        when Hash
          answer[key] = convert_hash(value)
        when Array
          answer[key] = convert_array(value)
        end
      end
      answer
    end

    def convert_array(answer)
      answer.map do |value|
        case value
        when Hash
          convert_hash(value)
        when Array
          convert_array(value)
        else
          value
        end
      end
    end

    # Reworks answer to translate {INT_FIELDS}, {FLOAT_FIELDS} and {BOOL_FIELDS}.
    # @param answer API answer field.
    # @return Translated answer.
    def convert(answer)
      case answer
      when Hash
        convert_hash(answer)
      when Array
        convert_array(answer)
      else
        answer
      end
    end
 
    # Handles API answer. Take in care `:field` option.
    # @param answer API answer field.
    # @return Converted answer by default.
    # @see #convert
    # @see #opts
    def handle_answer(answer)
      return nil  if answer.nil?
      answer = convert(answer)
      field = opts[:field]
      if field
        answer = answer[field]
      end
      answer
    end

    private :convert_array, :convert_hash
  end
end
