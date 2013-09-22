# -*- encoding : utf-8 -*-

require 'reg_api2/result_contract/default'

# Waits for single field in answer field and returns it only.
class RegApi2::ResultContract::SingleField < RegApi2::ResultContract::Default
  def handle_answer answer
    answer = super(answer)
    field = opts[:field]
    unless answer[field]
      raise RegApi2::ContractError.new(
        "#{field} field should be found in API result.",
        [ field ]
      )
    end
    answer[field]
  end
end
