# -*- encoding : utf-8 -*-
describe RegApi2 do
  before(:all) do
    RegApi2.user = 'test'
    RegApi2.password = 'test'
    RegApi2.lang = 'ru'
  end

  describe :nop do
    it "should raise nothing" do
      lambda { RegApi2.common.nop }.should_not raise_error
    end
    it "should return login" do
      RegApi2.common.nop['login'].should == RegApi2.user
    end
  end

  describe :reseller_nop do
    it "should raise nothing" do
      lambda { RegApi2.common.reseller_nop }.should_not raise_error
    end
    it "should return login" do
      RegApi2.common.reseller_nop['login'].should == RegApi2.user
    end
  end

  describe :get_user_id do
    it "should raise nothing" do
      lambda { RegApi2.common.get_user_id }.should_not raise_error
    end
    it "should return user id" do
      RegApi2.common.get_user_id['user_id'].should be_kind_of(Fixnum)
    end
  end
end
