# -*- encoding : utf-8 -*-

describe RegApi2::Bill do

  include RegApi2

  describe :nop do
    it "should raise nothing" do
      expect { bill.nop }.not_to raise_error
    end

    it "should return nil" do
      expect(bill.nop).to be_nil
    end

    it "should return bill if specified" do
      expect(bill.nop(bill_id: 12345)).to have_exactly(1).bill
    end

    it "should return bills if specified" do
      expect(bill.nop(bills: [ 12345, 12346 ])).to have_exactly(2).bills
    end
  end

  describe :get_not_payed do
    it "should raise nothing" do
      expect { bill.get_not_payed }.not_to raise_error
    end

    it "should return something real" do
      expect(bill.get_not_payed).to have_exactly(1).bill
    end
  end

  describe :get_for_period do
    it "should raise ContractError without dates" do
      expect { bill.get_for_period }.to raise_error RegApi2::ContractError
    end

    it "should return something real" do
      expect(bill.get_for_period(
        start_date: Date.new(2000, 1, 1),
        end_date: Date.new(2015, 1, 1)
      )).to have_exactly(1).bill
    end
  end

  describe :change_pay_type do
    it "should raise if no currency given" do
      expect { bill.change_pay_type(
        pay_type: :prepay,
        bills: [ 123456 ]
      ) }.to raise_error RegApi2::ContractError
    end
    it "should raise if no pay_type given" do
      expect { bill.change_pay_type(
        currency: :RUR,
        bills: [ 123456 ]
      ) }.to raise_error RegApi2::ContractError
    end
    it "should raise nothing if ok" do
      expect(bill.change_pay_type(
        pay_type: :prepay,
        currency: :RUR,
        bills: [ 123456 ]
      )).to have_exactly(1).bill
    end
  end

  describe :delete do
    it "should remove three bills if specified" do
      ans = bill.delete(
        bills: [ { bill_id: 12345 }, { bill_id: 12346 }, { bill_id: 12347 } ]
      )
      expect(ans.map { |b| b.bill_id }).to eq([ 12345, 12346, 12347 ])
      ans.each { |b| expect(b.result).to eq('success') }
      ans.each { |b| expect(b.status).to eq('deleted') }
    end
  end
end
