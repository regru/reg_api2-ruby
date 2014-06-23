# -*- encoding : utf-8 -*-

class Testplate < RegApi2::Entity::EntityBase
  attr_accessor :a, :b
end

describe Testplate do
  let!(:plate) { Testplate.new(a: 4, b: 5) }

  it "should be initialized with hash" do
    expect(plate.a).to eq(4)
    expect(plate.b).to eq(5)
  end

  it "should return the hash" do
    expect(plate.to_hash).to eq({ a: 4, b: 5 })
  end

  it "should return json" do
    expect(plate.to_json).to match(/^{.?"a":4/)
  end
end
