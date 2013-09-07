module RegApi2
  module Util
    def constantize str
      str.to_s.split('_').map { |w| w.capitalize }.join('')
    end

    extend self
  end
end