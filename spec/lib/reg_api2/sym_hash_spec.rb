# -*- encoding : utf-8 -*-

describe RegApi2::SymHash do

  let!(:hash) { RegApi2::SymHash.new }

  describe :new do
    it "should be kind of Hash" do
      expect(hash).to be_kind_of(Hash)
    end
  end

  describe :method_missing do
    it "should assign key" do
      hash.unique_key = "unique"
      expect(hash["unique_key"]).to eq("unique")
    end

    it "should reassign key" do
      hash["next_key"] = "a"
      hash.next_key = "b"
      expect(hash["next_key"]).to eq("b")
    end

    it "should return value" do
      hash["another_key"] = "f"
      expect(hash.another_key).to eq("f")
    end

    it "should return bool if key ends with ?" do
      hash.ping = 15
      expect(hash).to be_ping
      hash.pong = nil
      expect(hash).not_to be_pong
    end

    it "should return nil unless keypair present" do
      expect(hash.absent_key).to be_nil
    end
  end

  describe :respond_to? do
    it "should always respond to any method" do
      expect(hash).to respond_to(:any_method)
    end
  end

  describe :include? do
    it "should be has_key?" do
      allow(hash).to receive(:has_key?).with("what").and_return(true)
      expect(hash.include?("what")).to be true
    end
  end

  describe :has_key? do
    it "should represent symbol keys as strings" do
      hash["frank"] = 56
      expect(hash[:frank]).to eq(56)
      expect(hash).to have_key("frank")
      expect(hash).to have_key(:frank)

      hash[:bravo] = 56
      expect(hash["bravo"]).to eq(56)
      expect(hash).to have_key("bravo")
      expect(hash).to have_key(:bravo)
    end
  end

  describe "self.from" do
    it "should deeply clone structures with replacing hashes with SymHash" do
      res = RegApi2::SymHash.from([{a: 1}, {b: 2}, [ 1, 2, 3 ]])
      expect(res).to be_kind_of(Array)
      expect(res).to have_exactly(3).elements
      expect(res.first).to be_kind_of(RegApi2::SymHash)
      expect(res[1]).to be_kind_of(RegApi2::SymHash)
      expect(res.last).not_to be_kind_of(RegApi2::SymHash)
      expect(res.last).to be_kind_of(Array)
      expect(res.last).to eq([ 1, 2 , 3 ])
    end
  end
end
