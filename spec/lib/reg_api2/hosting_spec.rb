# -*- encoding : utf-8 -*-

describe RegApi2::Hosting do

  include RegApi2

  describe :nop do
    it "should return nil" do
      hosting.nop.should be_nil
    end
  end

  describe :get_jelastic_refill_url do
    it "should return nil" do
      hosting.get_jelastic_refill_url.should == "https://test1.ru"
    end
  end

  describe :set_jelastic_refill_url do
    it "should return nil" do
      hosting.set_jelastic_refill_url(url: "http://ya.ru/").should be_nil
    end
  end

end
