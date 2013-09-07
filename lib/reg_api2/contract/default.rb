# -*- encoding : utf-8 -*-
module RegApi2
  module Contract
    class Default
      attr_reader :opts

      def initialize(opts = {})
        @opts = opts
      end

      def handle_result(result)
        handle_answer(result['answer'])
      end
   
      def handle_answer(answer)
        answer
      end
    end
  end
end
