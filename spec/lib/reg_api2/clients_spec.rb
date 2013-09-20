# -*- encoding : utf-8 -*-
describe RegApi2::Clients do

  include RegApi2

  describe :nop do
    it "should raise NO_SUCH_COMMAND" do
      lambda { clients.nop }.should raise_error RegApi2::ApiError
      lambda { clients.nop }.should raise_error /NO_SUCH_COMMAND/
    end
  end
end
