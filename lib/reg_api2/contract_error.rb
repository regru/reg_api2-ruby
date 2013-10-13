module RegApi2
  # API Contract Error.
  # Raised when input parameters doesn't pass Ruby client tests.
  class ContractError < ArgumentError
    # @!attribute [r] fields
    # @return [Array<String>] Wrong fields. 
    attr_reader :fields

    def initialize message, fields = []
      super message
      fields = []  if fields.nil?
      fields = [ fields ]  unless fields.kind_of?(Array)
      @fields = fields
    end
  end
end
