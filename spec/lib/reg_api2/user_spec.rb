# -*- encoding : utf-8 -*-

require 'blueprints/user'

describe RegApi2::User do

  include RegApi2
  FakeUser = RegApi2::Entity::User

  describe :nop do
    it "should raise nothing" do
      expect { user.nop }.not_to raise_error
    end
    
    it "should return nil" do
      expect(user.nop).to be_nil
    end
  end

  describe :create do
    it "should raise ContractError unless user_login provided." do
      expect { user.create(FakeUser.make(:bad_login)) }.to raise_error RegApi2::ContractError
      expect { user.create(FakeUser.make(:bad_login)) }.to raise_error /user_login/
    end

    it "should raise ContractError unless user_password provided." do
      expect { user.create(FakeUser.make(:bad_password)) }.to raise_error RegApi2::ContractError
      expect { user.create(FakeUser.make(:bad_password)) }.to raise_error /user_password/
    end

    it "should raise ContractError unless user_email provided." do
      expect { user.create(FakeUser.make(:bad_email)) }.to raise_error RegApi2::ContractError
      expect { user.create(FakeUser.make(:bad_email)) }.to raise_error /user_email/
    end
  
    it "should raise ContractError unless user_country_code provided." do
      expect { user.create(FakeUser.make(:bad_country_code)) }.to raise_error RegApi2::ContractError
      expect { user.create(FakeUser.make(:bad_country_code)) }.to raise_error /user_country_code/
    end

    it "should create user with valid data." do
      expect { user.create(FakeUser.make(:good_user)) }.not_to raise_error
      expect(user.create(FakeUser.make(:good_user))).to eq("777")
    end
  end

  describe :get_statistics do
    it "should return user statistics" do
      expect(user.get_statistics.keys.sort).to eq(%w[
        active_domains_cnt 
        active_domains_get_ctrl_cnt 
        balance_total 
        domain_folders_cnt 
        renew_domains_cnt 
        renew_domains_get_ctrl_cnt 
        undelegated_domains_cnt 
      ])
    end
  end

  describe :get_balance do
    it "should return user balance" do
      expect(user.get_balance(currency: :USD).keys.sort).to eq(%w[
        currency
        prepay
      ])
    end
  end

  describe :refill_balance do
    it "should fill balance" do
      ans = user.refill_balance(
        pay_type: :WM, 
        wmid: 123456789012, 
        currency: :RUR,
        amount: 1000
      )
      expect(ans.currency).to eq('RUR')
      expect(ans.pay_type).to eq('WM')
      expect(ans.payment).to eq(1000)
      expect(ans.total_payment).to eq(1000)
      expect(ans).to have_key :wm_invid
    end
  end
end
