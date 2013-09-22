# -*- encoding : utf-8 -*-

require 'reg_api2/sym_hash'

module RegApi2
  # Contracts for API results.
  # Take a look at {RegApi2::DEFAULT_RESULT_CONTRACT} for defaults.
  module ResultContract
    # Waits for answer field and returns it only.
    class Default
      # Fields that will be converted to {Fixnum}.
      INT_FIELDS = %w[
        active_domains_cnt
        active_domains_get_ctrl_cnt
        domain_folders_cnt
        renew_domains_cnt
        renew_domains_get_ctrl_cnt
        undelegated_domains_cnt
        bill_id
      ].freeze

      # Fields that will be converted to {Float}.
      FLOAT_FIELDS = %w[
        amount
        total_amount
        payment
        total_payment
      ].freeze

      # Fields that will be converted to {TrueClass or FalseClass}.
      BOOL_FIELDS = %w[
        ].freeze

      attr_reader :opts

      def initialize(opts = {})
        @opts = opts
      end

      # Extracts answer field and returns it wrapped by {#handle_answer}.
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
              answer[key] = !!value.to_i
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
   
      # Return passed argument by default.
      def handle_answer(answer)
        answer = convert(answer)
        field = opts[:field]
        if field
          answer = answer[field]
        end
        answer
      end
    end
  end
end
