# -*- encoding : utf-8 -*-
describe RegApi2::Shop do

  include RegApi2

  describe :nop do
    it "should raise nothing" do
      expect { shop.nop }.not_to raise_error
    end

    it "should return lot id if domain exist" do
      expect(RegApi2.shop.nop(dname: 'test.ru')).to have_key( 'lot_id' )
    end
  end
end
