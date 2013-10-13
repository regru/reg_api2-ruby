module RegApi2
  # Networking Error.
  # Raised when response doesn't meet HTTP 200 OK status.
  class NetError < IOError
  end
end
