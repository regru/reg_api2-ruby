# -*- encoding : utf-8 -*-
describe RegApi2::Common do

  include RegApi2

  describe :nop do
    it "should raise nothing" do
      expect { common.nop }.not_to raise_error
    end
    it "should return login" do
      expect(common.nop.login).to eq(RegApi2.username)
    end
  end

  describe :reseller_nop do
    it "should raise nothing" do
      expect { common.reseller_nop }.not_to raise_error
    end
    it "should return login" do
      expect(common.reseller_nop.login).to eq(RegApi2.username)
    end
  end

  describe :get_user_id do
    it "should raise nothing" do
      expect { common.get_user_id }.not_to raise_error
    end
    it "should return user id" do
      expect(common.get_user_id).to be_kind_of(Fixnum)
    end
  end

  describe :get_service_id do
    it "should raise nothing" do
      expect { common.get_service_id(service_id: 123456) }.not_to raise_error
    end
    it "should return user id" do
      common.get_service_id(service_id: 123456) == 123456
    end
  end
end
