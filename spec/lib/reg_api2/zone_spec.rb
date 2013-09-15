# -*- encoding : utf-8 -*-

describe RegApi2::Zone do
  describe :nop do
    it "should raise when no args" do
      lambda { RegApi2.zone.nop }.should raise_error
    end
    
    it "should return domains if specified" do
      ans = RegApi2.zone.nop(domains: [ { dname: "test.ru" }, { dname: "test.com" } ])
      ans.domains.map(&:servtype).should == [ 'domain', 'domain' ]
      ans.domains.map(&:result).should == [ 'success', 'success' ]
    end  
  end

end
