# -*- encoding : utf-8 -*-
describe RegApi2::RequestContract::Default do

  let!(:contract) {
    RegApi2::RequestContract::Default.new(
      required: %w[ a b ],
      optional: %w[ c d ]
    )
  }

  describe :initialize do
    it "should assign opts" do
      contract.opts.should == {
        required: %w[ a b ],
        optional: %w[ c d ]
      }
    end
  end

  # TODO: specs

end
