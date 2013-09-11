# -*- encoding : utf-8 -*-

describe RegApi2::Bill do
  describe :nop do
    it "should raise nothing" do
      lambda { RegApi2.bill.nop }.should_not raise_error
    end
    
    it "should return nil" do
      RegApi2.bill.nop.should be_nil
    end

    it "should return bill if specified" do
      RegApi2.bill.nop(bill_id: 12345).bills.should have(1).bill
    end

    it "should return bills if specified" do
      RegApi2.bill.nop(bills: [ 12345, 12346 ]).bills.should have(2).bills
    end  
  end

end
