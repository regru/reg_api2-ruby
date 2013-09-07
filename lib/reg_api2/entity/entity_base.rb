require 'yajl'

module RegApi2
  module Entity
    class EntityBase
      def to_hash
        h = {}
        methods = self.class.public_instance_methods(true).map(&:to_s)
        methods.select do |n|
          n =~ /^[^=\?!]+$/ && methods.detect { |n2| "#{n}=" == n2 }
        end.each do |n|
          h[n.to_sym] = self.send n.to_sym
        end
        h
      end

      def to_json
        Yajl::Encoder.encode to_hash
      end

      def initialize opts = {}
        opts.keys.each do |key|
          next  unless respond_to?("#{key}=")
          send("#{key}=", opts[key])
        end
      end
    end
  end
end
