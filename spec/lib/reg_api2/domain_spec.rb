# -*- encoding : utf-8 -*-
describe RegApi2::Domain do
  describe :nop do
    it "should raise nothing" do
      lambda { RegApi2.domain.nop }.should_not raise_error
    end

    it "should return service id if domain exist" do
      RegApi2.domain.nop(dname: 'test.ru').should be_nil
    end
  end
end
