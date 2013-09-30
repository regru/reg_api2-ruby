# -*- encoding : utf-8 -*-
describe RegApi2::ResultContract do

  let!(:contract) { RegApi2::ResultContract.new(a: 1, b: 4) }

  describe :initialize do
    it "should assign opts" do
      contract.opts.should == { a: 1, b: 4 }
    end
  end

  describe :handle_result do
    it "should return handle_answer" do
      expected = 'OOLOLLO'
      mock(contract).handle_answer({}) { expected } 
      contract.handle_result({ "answer" => {} }).should == expected
    end
  end

  describe :handle_answer do
    it "should return specified value" do
      contract.handle_answer("FX").should == "FX"
    end

    it "should return field value if exists" do
      contract = RegApi2::ResultContract.new(a:1, field: :a)
      contract.handle_result({ answer: { "a" => "FX" } }).should == "FX"
    end
  end

  describe :convert do
    it "should convert field of some types" do
      ans = contract.convert({
        active_domains_cnt: "6",
        success: "0",
        amount: "15",
        text: "2323" 
      })
      ans.should == {
        active_domains_cnt: 6,
        success: false,
        amount: 15.0,
        text: "2323"
      }
      ans = contract.convert({
        success: "1",
      })
      ans.should == {
        success: true,
      }
    end
  end
end
