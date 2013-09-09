# -*- encoding : utf-8 -*-

require 'reg_api2/sym_hash'

module RegApi2
  # Contracts for API results.
  # Take a look at {RegApi2::DEFAULT_RESULT_CONTRACT} for defaults.
  module ResultContract
    # Waits for answer field and returns it only.
    class Default
      attr_reader :opts

      def initialize(opts = {})
        @opts = opts
      end

      # Extracts answer field and returns it wrapped by {#handle_answer}.
      def handle_result(result)
        result = SymHash.from(result)
        handle_answer(result[:answer])
      end
   
      # Return passed argument by default.
      def handle_answer(answer)
        answer
      end
    end
  end
end
