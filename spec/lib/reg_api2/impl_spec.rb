# -*- encoding : utf-8 -*-

describe RegApi2 do
  describe :http do
    before(:each) do
      RegApi2.clear_http
    end

    after(:all) do
      RegApi2.clear_http
    end

    it "should #create_http at first call" do
      allow(RegApi2).to receive(:create_http).once.and_return(45)
      RegApi2.http.should == 45
    end

    it "should not #create_http at next call" do
      allow(RegApi2).to receive(:create_http).once.and_return(45)
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
      allow(RegApi2).to receive(:ca_cert_path).and_return("file")
      http = RegApi2.create_http
      http.verify_mode.should == OpenSSL::SSL::VERIFY_PEER
      http.ca_file.should == "file"
    end

    it "should use pem with pem_password" do
      allow(RegApi2).to receive(:pem).and_return("pem")
      allow(RegApi2).to receive(:pem_password).and_return("pem_password")
      pem = Object.new
      key = Object.new
      allow(OpenSSL::X509::Certificate).to receive(:new).with("pem").and_return(pem)
      allow(OpenSSL::PKey::RSA).to receive(:new).with("pem", "pem_password").and_return(key)

      http = RegApi2.create_http
      http.cert.should == pem
      http.key.should  == key
    end

    it "should use pem without pem_password" do
      allow(RegApi2).to receive(:pem).and_return("pem")
      allow(RegApi2).to receive(:pem_password).and_return(nil)
      pem = Object.new
      key = Object.new
      allow(OpenSSL::X509::Certificate).to receive(:new).with("pem").and_return(pem)
      allow(OpenSSL::PKey::RSA).to receive(:new).with("pem").and_return(key)

      http = RegApi2.create_http
      http.cert.should == pem
      http.key.should_not  be_nil
    end
  end

  describe :make_action do

    it "should raise ApiError with NO_SUCH_COMMAND code on absent command" do
      lambda do
        RegApi2.make_action(:bad, :command, {}, {})
      end.should raise_error RegApi2::ApiError
      lambda do
        RegApi2.make_action(:bad, :command, {}, {})
      end.should raise_error /NO_SUCH_COMMAND/
    end
  end
end
