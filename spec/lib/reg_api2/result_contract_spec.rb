# -*- encoding : utf-8 -*-
describe RegApi2::ResultContract do

  let!(:contract) { RegApi2::ResultContract.new(a: 1, b: 4) }

  describe :initialize do
    it "should assign opts" do
      expect(contract.opts).to eq({ a: 1, b: 4 })
    end
  end

  describe :handle_result do
    it "should return handle_answer" do
      expected = 'OOLOLLO'
      expect(contract).to receive(:handle_answer).with({}).and_return(expected) 
      expect(contract.handle_result({ "answer" => {} })).to eq(expected)
    end
  end

  describe :handle_answer do
    it "should return specified value" do
      expect(contract.handle_answer("FX")).to eq("FX")
    end

    it "should return field value if exists" do
      contract = RegApi2::ResultContract.new(a:1, field: :a)
      expect(contract.handle_result({ answer: { "a" => "FX" } })).to eq("FX")
    end
  end

  describe :convert do
    it "should convert fields of some types for hashes" do
      ans = contract.convert({
        active_domains_cnt: "6",
        success: "0",
        amount: "15",
        text: "2323" 
      })
      expect(ans).to eq({
        active_domains_cnt: 6,
        success: false,
        amount: 15.0,
        text: "2323"
      })
      ans = contract.convert({
        success: "1",
      })
      expect(ans).to eq({
        success: true,
      })
    end

    it "should proceed arrays too" do
      ans = contract.convert([ 1, 2, [ 1 ], { amount: "4543" } ])
      expect(ans).to eq([ 1, 2, [ 1 ], { amount: 4543.0} ])
    end
  end
end
