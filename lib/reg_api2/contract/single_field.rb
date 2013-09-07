# -*- encoding : utf-8 -*-

require 'reg_api2/contract/default'

class RegApi2::Contract::SingleField < RegApi2::Contract::Default
  def handle_answer answer
    field = opts[:field]
    unless answer[field]
      raise RegApi2::ContractError.new(
        "#{field} field should be found in API result."
      )
    end
    answer[field]
  end
end
