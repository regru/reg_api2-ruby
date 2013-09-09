# -*- encoding : utf-8 -*-
describe RegApi2::Domain do
  describe :nop do
    it "should raise nothing" do
      lambda { RegApi2.domain.nop }.should_not raise_error
    end
  end
end
