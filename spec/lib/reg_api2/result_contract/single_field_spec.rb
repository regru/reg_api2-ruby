# -*- encoding : utf-8 -*-
describe RegApi2::ResultContract::SingleField do

  let!(:contract) { RegApi2::ResultContract::SingleField.new(field: 'one') }

  describe :initialize do
    it "should assign opts" do
      contract.opts.should == { field: 'one' }
    end
  end

  describe :handle_answer do
    it "should return field value if exists" do
      contract.handle_answer({ "one" => "FX" }).should == "FX"
    end

    it "should raise ContractError nil unless exists" do
      lambda { contract.handle_answer({}) }.should raise_error RegApi2::ContractError
      lambda { contract.handle_answer({}) }.should raise_error /one/
    end
  end
end
