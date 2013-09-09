module RegApi2
  class SymHash < Hash
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

    def has_key?(key)
      key.kind_of?(Symbol) ? super.has_key?(key.to_s) : super(key)
    end

    def [](key)
      key.kind_of?(Symbol) ? self[key.to_s] : super(key)
    end

    def []=(key, new_value)
      key.kind_of?(Symbol) ? self[key.to_s]=new_value : super(key, new_value)
    end

    def respond_to?(key)
      has_key?(key) || true
    end

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
