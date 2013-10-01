# -*- encoding : utf-8 -*-

describe RegApi2 do
  describe :http do
    before(:each) do
      RegApi2.clear_http
    end

    it "should #create_http at first call" do
      mock(RegApi2).create_http { 45 }.times(1)
      RegApi2.http.should == 45
    end

    it "should not #create_http at next call" do
      mock(RegApi2).create_http { 45 }.times(1)
      RegApi2.http.should == 45
      RegApi2.http.should == 45
    end
  end

  describe :create_http do
    it "should create Net::HTTP object" do
      http = RegApi2.create_http
      http.should be_kind_of(Net::HTTP)
      http.should be_use_ssl
      http.verify_mode.should == OpenSSL::SSL::VERIFY_NONE
    end

    it "should use ca_cert_path if exists" do
      any_instance_of(Net::HTTP) do |instance|
        proxy(instance).verify_mode=(OpenSSL::SSL::VERIFY_PEER)
        proxy(instance).ca_file=("file")
      end
      mock(RegApi2).ca_cert_path { "file" }.any_times
      http = RegApi2.create_http
      http.verify_mode.should == OpenSSL::SSL::VERIFY_PEER
      http.ca_file.should == "file"
    end

    it "should use pem with pem_password" do
      mock(RegApi2).pem { "pem" }.any_times
      mock(RegApi2).pem_password { "pem_password" }.any_times
      pem = Object.new
      key = Object.new
      mock(OpenSSL::X509::Certificate).new("pem") { pem }
      mock(OpenSSL::PKey::RSA).new("pem", "pem_password") { key }

      http = RegApi2.create_http
      http.cert.should == pem
      http.key.should  == key
    end

    it "should use pem without pem_password" do
      mock(RegApi2).pem { "pem" }.any_times
      mock(RegApi2).pem_password { nil }.any_times
      pem = Object.new
      key = Object.new
      mock(OpenSSL::X509::Certificate).new("pem") { pem }
      mock(OpenSSL::PKey::RSA).new("pem") { key }

      http = RegApi2.create_http
      http.cert.should == pem
      http.key.should_not  be_nil
    end  end
end
