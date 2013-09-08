module RegApi2
  # Internal utilities
  module Util
    # Constantizes specified str
    # @param [String] str String to constantize. 
    # @return [String] Constantized string.
    def constantize str
      str.to_s.split('_').map { |w| w.capitalize }.join('')
    end

    extend self
  end
end