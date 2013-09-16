# -*- encoding : utf-8 -*-

require 'ipaddr'

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

  describe :add_alias do
    it "should understood IPAddr's" do
      ans = RegApi2.zone.add_alias(
        domains: [ { dname: "test.ru" }, { dname: "test.com" } ],
        subdomain: '@',
        ipaddr: IPAddr.new("111.111.111.111")
      )
      ans.domains.map(&:result).should == [ 'success', 'success' ]
    end

    it "should understood ip addresses as strings too" do
      ans = RegApi2.zone.add_alias(
        domains: [ { dname: "test.ru" }, { dname: "test.com" } ],
        subdomain: '*',
        ipaddr: "111.111.111.111"
      )
      ans.domains.map(&:result).should == [ 'success', 'success' ]
    end
  end
end
