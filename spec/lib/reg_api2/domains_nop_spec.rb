# -*- encoding : utf-8 -*-
describe RegApi2 do
  before(:all) do
    RegApi2.user = 'test'
    RegApi2.password = 'test'
    RegApi2.lang = 'ru'
  end

  describe :nop do
    it "should raise NO_SUCH_COMMAND" do
      lambda { RegApi2::Domains.nop }.should raise_error RegApi2::ApiError
      lambda { RegApi2.domains.nop }.should raise_error /NO_SUCH_COMMAND/
    end
  end
end
