# -*- encoding : utf-8 -*-
describe RegApi2 do

  describe :nop do
    it "should return list of services if requested" do
      ans = RegApi2.service.nop(services: [
        { dname:"test.ru" },
        { dname: "test.su", servtype: "srv_hosting_ispmgr" },
        { service_id: 111111 },
        { service_id: "22bug22" },
        { surprise: "surprise.ru" }
      ])
      ans.services.map do |rec|
        rec.result == 'success' ? rec['dname'] : rec['error_code']
      end.sort.should == %w[ INVALID_SERVICE_ID NO_DOMAIN test.ru test.su test12347.ru ]
    end
  end

  describe :get_prices do
    it "should return prices" do
      ans = RegApi2.service.get_prices show_renew_data: true
      ans.should have_key :prices
    end
  end
end
