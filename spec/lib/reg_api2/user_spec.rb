# -*- encoding : utf-8 -*-

require 'blueprints/user'

describe RegApi2 do
  describe :nop do
    it "should raise nothing" do
      lambda { RegApi2.user.nop }.should_not raise_error
    end
    
    it "should return nil" do
      RegApi2.user.nop.should be_nil
    end
  end

  describe :create do
    it "should raise ContractError unless user_login provided." do
      lambda { RegApi2.user.create(RegApi2::Entity::User.make(:bad_login)) }.should raise_error RegApi2::ContractError
      lambda { RegApi2.user.create(RegApi2::Entity::User.make(:bad_login)) }.should raise_error /user_login/
    end

    it "should raise ContractError unless user_password provided." do
      lambda { RegApi2.user.create(RegApi2::Entity::User.make(:bad_password)) }.should raise_error RegApi2::ContractError
      lambda { RegApi2.user.create(RegApi2::Entity::User.make(:bad_password)) }.should raise_error /user_password/
    end

    it "should raise ContractError unless user_email provided." do
      lambda { RegApi2.user.create(RegApi2::Entity::User.make(:bad_email)) }.should raise_error RegApi2::ContractError
      lambda { RegApi2.user.create(RegApi2::Entity::User.make(:bad_email)) }.should raise_error /user_email/
    end
  
    it "should raise ContractError unless user_country_code provided." do
      lambda { RegApi2.user.create(RegApi2::Entity::User.make(:bad_country_code)) }.should raise_error RegApi2::ContractError
      lambda { RegApi2.user.create(RegApi2::Entity::User.make(:bad_country_code)) }.should raise_error /user_country_code/
    end

    it "should create user with valid data." do
      lambda { RegApi2.user.create(RegApi2::Entity::User.make(:good_user)) }.should_not raise_error
      RegApi2.user.create(RegApi2::Entity::User.make(:good_user)).should == "777"
    end
  end

  describe :get_statistics do
    it "should return user statistics" do
      RegApi2.user.get_statistics.keys.sort.should == %w[
        active_domains_cnt 
        active_domains_get_ctrl_cnt 
        balance_total 
        domain_folders_cnt 
        renew_domains_cnt 
        renew_domains_get_ctrl_cnt 
        undelegated_domains_cnt 
      ]
    end
  end
end
