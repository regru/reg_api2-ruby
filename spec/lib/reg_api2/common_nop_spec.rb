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
end
