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

  describe :get_not_payed do
    it "should raise nothing" do
      lambda { RegApi2.bill.get_not_payed }.should_not raise_error
    end

    it "should return something real" do
      RegApi2.bill.get_not_payed.bills.should have(1).bill
    end
  end

  describe :get_for_period do
    it "should raise ContractError without dates" do
      lambda { RegApi2.bill.get_for_period }.should raise_error RegApi2::ContractError
    end

    it "should return something real" do
      RegApi2.bill.get_for_period(
        start_date: Date.new(2000, 1, 1), end_date: Date.new(2015, 1, 1)
      ).bills.should have(1).bill
    end
  end

  describe :change_pay_type do
    it "should raise if no currency given" do
      lambda { RegApi2.bill.change_pay_type(pay_type: :prepay, bills: [ 123456 ] ) }.should raise_error RegApi2::ContractError
    end
    it "should raise if no pay_type given" do
      lambda { RegApi2.bill.change_pay_type(currency: :RUR, bills: [ 123456 ] ) }.should raise_error RegApi2::ContractError
    end
    it "should raise nothing if ok" do
      RegApi2.bill.change_pay_type(pay_type: :prepay, currency: :RUR, bills: [ 123456 ] ).bills.should have(1).bill
    end
  end

  describe :delete do
    it "should remove three bills if specified" do
      ans = RegApi2.bill.delete(bills: [ { bill_id: 12345 }, { bill_id: 12346 }, { bill_id: 12347 } ]).bills
      ans.map { |b| b.bill_id }.should == [ 12345, 12346, 12347 ]
      ans.each { |b| b.result.should == 'success' }
      ans.each { |b| b.status.should == 'deleted' }
    end
  end
end
