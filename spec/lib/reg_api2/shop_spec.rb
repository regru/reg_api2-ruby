# -*- encoding : utf-8 -*-
describe RegApi2::Shop do

  include RegApi2

  describe :nop do
    it "should raise nothing" do
      lambda { shop.nop }.should_not raise_error
    end

    it "should return lot id if domain exist" do
      RegApi2.shop.nop(dname: 'test.ru').should have_key( 'lot_id' )
    end
  end
end
