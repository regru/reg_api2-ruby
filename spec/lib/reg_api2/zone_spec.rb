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

  describe :add_aaaa do
    it "should understood IPAddr's" do
      ans = RegApi2.zone.add_aaaa(
        domains: [ { dname: "test.ru" }, { dname: "test.com" } ],
        subdomain: '@',
        ipaddr: IPAddr.new("aa11::a111:11aa:aaa1:aa1a")
      )
      ans.domains.map(&:result).should == [ 'success', 'success' ]
    end

    it "should understood ipv6 addresses as strings too" do
      ans = RegApi2.zone.add_aaaa(
        domains: [ { dname: "test.ru" }, { dname: "test.com" } ],
        subdomain: '*',
        ipaddr: "aa11::a111:11aa:aaa1:aa1a"
      )
      ans.domains.map(&:result).should == [ 'success', 'success' ]
    end
  end

  describe :add_cname do
    it "should assign mail subsomains to mx10.test.ru if specified" do
      ans = RegApi2.zone.add_cname(
        domains: [ { dname: "test.ru" }, { dname: "test.com" } ],
        subdomain: "mail",
        canonical_name: "mx10.test.ru"
      )
      ans.domains.map(&:result).should == [ 'success', 'success' ]
    end
  end

  describe :add_mx do
    it "should understood mail servers as IPAddr's" do
      ans = RegApi2.zone.add_mx(
        domains: [ { dname: "test.ru" }, { dname: "test.com" } ],
        subdomain: '@',
        mail_server: IPAddr.new("111.111.111.111")
      )
      ans.domains.map(&:result).should == [ 'success', 'success' ]
    end

    it "should understood mail servers as domains too" do
      ans = RegApi2.zone.add_mx(
        domains: [ { dname: "test.ru" }, { dname: "test.com" } ],
        subdomain: '@',
        priority: 1,
        mail_server: "mail"
      )
      ans.domains.map(&:result).should == [ 'success', 'success' ]
    end
  end

  describe :add_ns do
    it "should understood dns servers with record number" do
      ans = RegApi2.zone.add_ns(
        domains: [ { dname: "test.ru" }, { dname: "test.com" } ],
        subdomain: 'tt',
        dns_server: "ns.test.ru",
        record_number: 10
      )
      ans.domains.map(&:result).should == [ 'success', 'success' ]
    end

    it "should check record number" do
      lambda do
        RegApi2.zone.add_ns(
          domains: [ { dname: "test.ru" }, { dname: "test.com" } ],
          subdomain: 'tt',
          dns_server: "ns.test.ru",
          record_number: 'fg'
        )
      end.should raise_error RegApi2::ContractError
    end
  end

  describe :add_txt do
    it "should add text records" do
      ans = RegApi2.zone.add_txt(
        domains: [ { dname: "test.ru" }, { dname: "test.com" } ],
        subdomain: 'mail',
        text: "testmail"
      )
      ans.domains.map(&:result).should == [ 'success', 'success' ]
    end
  end

  describe :add_srv do
    it "Make the sip.test.ru server handle SIP calls destined to xxx@test.ru and xxx@test.com on port 5060 over UDP." do
      ans = RegApi2.zone.add_srv(
        domains: [ { dname: "test.ru" }, { dname: "test.com" } ],
        service: '_sip._udp',
        priority: 0,
        port: 5060,
        target: "sip.test.ru"
      )
      ans.domains.map(&:result).should == [ 'success', 'success' ]
    end
  end

  describe :get_resource_records do
    it "should get resource records" do
      ans = RegApi2.zone.get_resource_records(
        domains: [ { dname: "test.ru" }, { dname: "test.com" } ]
      )
      ans.domains.map(&:result).should == [ 'success', 'success' ]
      ans.domains.map(&:rrs).should be_kind_of(Array)
    end
  end

  describe :update_records do
    it "should update records" do
      ans = RegApi2.zone.update_records domain_name: "test.ru", action_list: [
        { action: :add_alias, subdomain: "www", ipaddr: "11.22.33.44" },
        { action: :add_cname, subdomain: "@", canonical_name: "www.test.ru" }
      ]
      ans.domains.map(&:result).should == [ 'success' ]
      ans.domains.first.action_list.map(&:result).should == [ 'success', 'success' ]
    end
  end

  describe :update_soa do
    it "should update zone TTL" do
      ans = RegApi2.zone.update_soa(
        domains: [ { dname: "test.ru" }, { dname: "test.com" } ],
        ttl: "1d",
        minimum_ttl: "4h"
      )
      ans.domains.map(&:result).should == [ 'success', 'success' ]
    end
  end

  describe :tune_forwarding do
    it "should add resource records required for web forwarding" do
      ans = RegApi2.zone.tune_forwarding(
        domains: [ { dname: "test.ru" }, { dname: "test.com" } ],
      )
      ans.domains.map(&:result).should == [ 'success', 'success' ]
    end
  end

  describe :clear_forwarding do
    it "should delete resource records required for web forwarding" do
      ans = RegApi2.zone.clear_forwarding(
        domains: [ { dname: "test.ru" }, { dname: "test.com" } ],
      )
      ans.domains.map(&:result).should == [ 'success', 'success' ]
    end
  end

  describe :tune_parking do
    it "should add resource records required for domain parking" do
      ans = RegApi2.zone.tune_parking(
        domains: [ { dname: "test.ru" }, { dname: "test.com" } ],
      )
      ans.domains.map(&:result).should == [ 'success', 'success' ]
    end
  end

  describe :clear_parking do
    it "should delete resource records required for domain parking" do
      ans = RegApi2.zone.clear_parking(
        domains: [ { dname: "test.ru" }, { dname: "test.com" } ],
      )
      ans.domains.map(&:result).should == [ 'success', 'success' ]
    end
  end
end
