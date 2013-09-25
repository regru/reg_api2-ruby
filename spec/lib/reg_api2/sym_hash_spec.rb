# -*- encoding : utf-8 -*-

describe RegApi2::SymHash do

  let!(:hash) { RegApi2::SymHash.new }

  describe :new do
    it "should be kind of Hash" do
      hash.should be_kind_of(Hash)
    end
  end

  describe :method_missing do
    it "should assign key" do
      hash.unique_key = "unique"
      hash["unique_key"].should == "unique"
    end

    it "should reassign key" do
      hash["next_key"] = "a"
      hash.next_key = "b"
      hash["next_key"].should == "b"
    end

    it "should return value" do
      hash["another_key"] = "f"
      hash.another_key.should == "f"
    end

    it "should return bool if key ends with ?" do
      hash.ping = 15
      hash.should be_ping
      hash.pong = nil
      hash.should_not be_pong
    end

    it "should return nil unless keypair present" do
      hash.absent_key.should be_nil
    end 
  end

  describe :respond_to? do
    it "should always respond to any method" do
      hash.should respond_to(:any_method)
    end
  end

  describe :include? do
    it "should be has_key?" do
      mock(hash).has_key?("what") { true }
      hash.include?("what").should be_true
    end
  end

  describe :has_key? do
    it "should represent symbol keys as strings" do
      hash["frank"] = 56
      hash[:frank].should == 56
      hash.should have_key("frank")
      hash.should have_key(:frank)

      hash[:bravo] = 56
      hash["bravo"].should == 56
      hash.should have_key("bravo")
      hash.should have_key(:bravo)
    end
  end

  describe "self.from" do
    it "should deeply clone structures with replacing hashes with SymHash" do
      res = RegApi2::SymHash.from([{a: 1}, {b: 2}, [ 1, 2, 3 ]])
      res.should be_kind_of(Array)
      res.should have(3).elements
      res.first.should be_kind_of(RegApi2::SymHash)
      res[1].should be_kind_of(RegApi2::SymHash)
      res.last.should_not be_kind_of(RegApi2::SymHash)
      res.last.should be_kind_of(Array)
      res.last.should == [ 1, 2 , 3 ]
    end
  end
end
