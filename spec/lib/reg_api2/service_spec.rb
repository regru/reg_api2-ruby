# -*- encoding : utf-8 -*-
describe RegApi2::Service do

  include RegApi2

  describe :nop do
    it "should return list of services if requested" do
      ans = service.nop(services: [
        { dname:"test.ru" },
        { dname: "test.su", servtype: "srv_hosting_ispmgr" },
        { service_id: 111111 },
        { service_id: "22bug22" },
        { surprise: "surprise.ru" }
      ])
      expect(ans.map do |rec|
        rec.result == 'success' ? rec.dname : rec.error_code
      end.sort).to eq(%w[ INVALID_SERVICE_ID NO_DOMAIN test.ru test.su test12347.ru ])
    end
  end

  describe :get_prices do
    it "should return prices" do
      ans = service.get_prices show_renew_data: true
      expect(ans).to have_key :prices
    end
  end

  describe :get_servtype_details do
    it "should return service type details" do
      ans = service.get_servtype_details servtype: :srv_hosting_ispmgr
      expect(ans.first).to have_key :commonname
    end
  end

  describe :create do
    it "should create srv_hosting_ispmgr service" do
      ans = service.create dname: 'qqq.ru', servtype: :srv_hosting_ispmgr, period: 1, plan: 'Host-2-1209'
      expect(ans.descr).to match(/srv_hosting_ispmgr.+ordered/)
    end
  end

  describe :delete do
    it "should remove srv_hosting_ispmgr service" do
      ans = service.delete domain_name: 'test.ru', servtype: :srv_hosting_ispmgr
      expect(ans).to be_nil
    end
  end

  describe :get_list do
    it "should get list of domains" do
      ans = service.get_list servtype: :domain
      expect(ans).to be_kind_of Array
      expect(ans.map(&:servtype).uniq).to eq([ "domain"])
      ans.map(&:service_id).each { |id| expect(id).to be_kind_of Fixnum }
    end
  end

  describe :get_dedicated_server_list do
    it "should get list of dedicated servers" do
      ans = service.get_dedicated_server_list
      expect(ans).to be_kind_of Array
      ans.map(&:server_id).each { |id| expect(id).to be_kind_of Fixnum }
    end
  end

  describe :get_bills do
    it "should get list of services and bills" do
      ans = service.get_bills dname: "qqq.ru"
      expect(ans.services).to be_kind_of Array
      expect(ans.bills).to be_nil
    end
  end

  describe :refill do
    it "should refill by service id" do
      ans = service.refill service_id: 123456, amount: 10, currency: 'UAH'
      expect(ans.pay_notes).to include("success")
      expect(ans.pay_type).to eq("prepay")
      expect(ans.service_id).to eq(123456)
      expect(ans.payment).to be > 0
    end
  end
end
