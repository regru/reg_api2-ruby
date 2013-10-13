# -*- encoding : utf-8 -*-
module RegApi2
  # API Error from REG.API provider.
  # Please refer to {file:README.md#Common_error_codes common error codes}.
  class ApiError < StandardError
    # @!attribute [r] description
    # @return [String] Localized error description.
    attr_reader :description
    # @!attribute [r] params
    # @return [Hash] Optional error params.
    attr_reader :params

    def initialize code,  description, params
      super code
      @description = description
      @params = params ||  {}
    end

    # Extracts error arguments from specified json.
    # @param [Hash] json
    # @return [ApiError] Initialized error object.
    def self.from_json json
      new(
        json['error_code'],
        json['error_text'],
        json['error_params']
      )
    end
  end
end
