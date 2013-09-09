# -*- encoding : utf-8 -*-
describe RegApi2::Domain do
  describe :nop do
    it "should raise nothing" do
      lambda { RegApi2.domain.nop }.should_not raise_error
    end

    it "should return service id if domain exist"
    #  RegApi2.domain.nop(dname: 'test.ru').should be_nil
  end

  describe :get_prices do
    it "should return prices" do
      prices = RegApi2.domain.get_prices(show_renew_data: 1, show_update_data: 1, currency: 'USD')
      prices.should have_key("price_group")
      prices['currency'].should == 'USD'

    end
  end
end
