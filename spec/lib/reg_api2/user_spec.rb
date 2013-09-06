# -*- encoding : utf-8 -*-
describe RegApi2 do
  before(:all) do
    RegApi2.username = 'test'
    RegApi2.password = 'test'
    RegApi2.lang = 'ru'
  end

  describe :nop do
    it "should raise nothing" do
      lambda { RegApi2.user.nop }.should_not raise_error
    end
    
    it "should return nil" do
      RegApi2.user.nop.should be_nil
    end
  end
end
