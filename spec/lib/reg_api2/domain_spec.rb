# -*- encoding : utf-8 -*-
describe RegApi2::Domain do

  include RegApi2

  describe :nop do
    it "should raise nothing" do
      lambda { domain.nop }.should_not raise_error
    end

    it "should return service id if domain exist"
    #  RegApi2.domain.nop(dname: 'test.ru').should be_nil
  end

  describe :get_prices do
    it "should return prices" do
      prices = domain.get_prices(
        show_renew_data: true,
        show_update_data: true, 
        currency: :USD
      )
      prices.should have_key(:price_group)
      prices.currency.should == 'USD'
    end
  end

  describe :get_suggest do
    it "should return suggestions" do
      ans = domain.get_suggest word: 'house', additional_word: 'new', use_hyphen: false, tlds: [ :ru ]
      ans.should be_kind_of(Array)
    end
  end

  describe :get_deleted do
    it "should return deleted domains" do
      ans = domain.get_deleted(
        tlds:         'ru',
        deleted_from: '2013-10-01',
        deleted_to:   '2013-11-01',
        min_pr:       2,
        min_cy:       1
      )
      ans.should be_kind_of(Array)
    end
  end
end
