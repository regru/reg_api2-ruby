# -*- encoding : utf-8 -*-
module RegApi2
  # Contracts for API requests.
  # Take a look at {RegApi2::DEFAULT_REQUEST_CONTRACT} for defaults.
  module RequestContract
    # Checks for specified `required` fields.
    class Default
      attr_reader :opts

      def initialize(opts = {})
        @opts = opts
      end

      def to_hash arr
        return arr  if arr.nil? || arr.kind_of?(Hash)
        arr = [ arr ]  unless arr.kind_of?(Array)
        ret = {}
        arr.each { |key| ret[key] = {} }
        ret
      end

      def validate(form)
        required_fields = to_hash opts[:required]
        return  unless required_fields
        absent_fields = []
        required_fields.each_pair do |key, opts|
          unless form.has_key?(key)
            absent_fields << key
            next
          end
        end
        unless absent_fields.empty?
          raise RegApi2::ContractError.new(
            "Required fields missed: #{absent_fields.join(', ')}"
          )
        end
      end
    end
  end
end
