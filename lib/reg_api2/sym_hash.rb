module RegApi2
  # Hash with indifferent access to its elements.
  # Also have no difference between {String} ans {Symbol} keys. 
  # @see ResultContract
  class SymHash < Hash
    # Forms data with indifferent access from specified source.
    # @return [Object] Data with indifferent access
    def self.from(source)
      case source
      when Hash
        res = SymHash.new
        source.each_pair do |key, value|
          res[key] = self.from(value)
        end
        res
      when Array
        source.map do |el|
          self.from(el)
        end
      else
        source
      end
    end

    # Returns true if the given key is present in hsh.
    def has_key?(key)
      key.kind_of?(Symbol) ? self.has_key?(key.to_s) : super(key)
    end

    # Returns true if the given key is present in hsh.
    def include?(key)
      has_key?(key)
    end

    # Element Reference — Retrieves the value object corresponding to the key object. If not found, returns the default value (see {Hash::new} for details).
    def [](key)
      key.kind_of?(Symbol) ? self[key.to_s] : super(key)
    end

    # Element Assignment — Associates the value given by value with the key given by key. key should not have its value changed while it is in use as a key (a String passed as a key will be duplicated and frozen).
    def []=(key, new_value)
      key.kind_of?(Symbol) ? self[key.to_s]=new_value : super(key, new_value)
    end

    # Always true
    def respond_to?(key)
      true
    end

    # Sets or gets field in the hash.
    def method_missing(key, *args, &block)
      if key.to_s =~ /^(.+)=$/
        self[$1] = args.first
        return args.first
      end
      if key.to_s =~ /^(.+)\?$/
        return !!self[$1]
      end
      return self[key]  if has_key?(key)
      nil
    end
  end
end
