# -*- encoding : utf-8 -*-
describe RegApi2 do
  before(:all) do
    RegApi2.username = 'test'
    RegApi2.password = 'test'
    RegApi2.lang = 'ru'
  end

  describe :nop do
    it "should return list of services if requested" do
      answer = RegApi2.service.nop(services: [
        { dname:"test.ru" },
        { dname: "test.su", servtype: "srv_hosting_ispmgr" },
        { service_id: 111111 },
        { service_id: "22bug22" },
        { surprise: "surprise.ru" }
      ])
      answer['services'].map do |rec|
        rec['result'] == 'success' ? rec['dname'] : rec['error_code']
      end.sort.should == %w[ INVALID_SERVICE_ID NO_DOMAIN test.ru test.su test12347.ru ]
    end
  end
end
