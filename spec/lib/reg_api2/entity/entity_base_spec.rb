# -*- encoding : utf-8 -*-

class Testplate < RegApi2::Entity::EntityBase
  attr_accessor :a, :b
end

describe Testplate do
  let!(:plate) { Testplate.new(a: 4, b: 5) }

  it "should be initialized with hash" do
    plate.a.should == 4
    plate.b.should == 5
  end

  it "should return the hash" do
    plate.to_hash.should == { a: 4, b: 5 }
  end

  it "should return json" do
    plate.to_json.should =~ /^{.?"a":4/
  end
end
