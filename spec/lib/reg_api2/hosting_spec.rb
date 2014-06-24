# -*- encoding : utf-8 -*-

describe RegApi2::Hosting do

  include RegApi2

  describe :nop do
    it "should return nil" do
      expect(hosting.nop).to be_nil
    end
  end

  describe :get_jelastic_refill_url do
    it "should return \"https://test1.ru\"" do
      expect(hosting.get_jelastic_refill_url).to eq("https://test1.ru")
    end
  end

  describe :set_jelastic_refill_url do
    it "should return nil on success" do
      expect(hosting.set_jelastic_refill_url(url: "http://ya.ru/")).to be_nil
    end
  end

  describe :get_parallelswpb_constructor_url do
    xit "should return \"https://test1.ru\"" do
      expect(hosting.get_parallelswpb_constructor_url(service_id: 123456)).to eq("https://test1.ru")
    end
  end
end
