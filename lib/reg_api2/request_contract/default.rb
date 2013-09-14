# -*- encoding : utf-8 -*-
module RegApi2
  # Contracts for API requests.
  # Take a look at {RegApi2::DEFAULT_REQUEST_CONTRACT} for defaults.
  module RequestContract
    # Checks for specified `required` fields.
    # Also checks for `optional` fields.
    # Take in care :re option.
    class Default
      attr_reader :opts

      def initialize(opts = {})
        @opts = opts
      end

      # Normalizes `required` and `optional` fields to the form of Hash with options.
      # @param [NilClass,Hash,Array, etc.] arr Something to normalize.
      def to_hash arr
        return {}   if arr.nil?
        return arr  if arr.kind_of?(Hash)
        arr = [ arr.to_sym ]  unless arr.kind_of?(Array)
        ret = {}
        arr.each { |key| ret[key.to_sym] = {} }
        ret
      end

      # Gets fields to validate
      # @return [Hash] Fields to validate.
      def fields_to_validate
        required_fields = to_hash opts[:required]
        optional_fields = to_hash opts[:optional]
        required_fields.keys.each { |key| required_fields[key][:required] = true }
        optional_fields.merge(required_fields)
      end

      # Validates specified `value` with `re` field.
      # @param [Object] key Value to validate.
      # @param [Object] value Value to validate.
      # @param [Hash] opts opts with optional re field.
      # @raise ContractError
      def validate_re key, value, opts
        if opts[:re]
          if value !~ opts[:re]
            raise RegApi2::ContractError.new(
              "Field #{key} mismatch regular expression: #{value}"
            )
          end
        end
      end

      # Validates specified `form` with `required` and `optional` fields.
      # @param [Hash] form Form to validate.
      # @raise ContractError
      def validate(form)
        fields = fields_to_validate
        return form  if fields.empty?
        absent_fields = []
        fields.each_pair do |key, opts|
          if !form.has_key?(key) || form[key].nil?
            if opts[:required]
              absent_fields << key
            end
            next
          end

          validate_re key, form[key], opts

          if opts[:iso_date]
            form[key] = form[key].strftime("%Y-%m-%d")  if form[key].respond_to?(:strftime)
          end
        end
        unless absent_fields.empty?
          raise RegApi2::ContractError.new(
            "Required fields missed: #{absent_fields.join(', ')}"
          )
        end
        form
      end
    end
  end
end
