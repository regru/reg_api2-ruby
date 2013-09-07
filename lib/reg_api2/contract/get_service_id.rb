# -*- encoding : utf-8 -*-

require 'reg_api2/contract/default'

class RegApi2::Contract::GetServiceId < RegApi2::Contract::Default
  def handle_answer answer
    unless answer['service_id']
      raise ApiError.new( "service_id field should be found in API result." )
    end
    answer['service_id'].to_i
  end
end
