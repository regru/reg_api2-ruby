require 'yajl'

module RegApi2
  # Optional entities that can be used instead of clean hashes.
  module Entity
    # Base entity class.
    class EntityBase

      # Skipped property names.
      SKIPPED_MEMBERS = [
        "taguri" # from YAML mixin
      ].freeze

      # All r/w properties interpreted as symbol hash.
      # @return [Hash] properties as hash.
      def to_hash
        h = {}
        methods = self.class.public_instance_methods(true).map(&:to_s)
        methods.select do |n|
          true &&
          !SKIPPED_MEMBERS.detect { |n3| n3 == n } &&
          n =~ /^[^=\?!]+$/ &&
          methods.detect { |n2| "#{n}=" == n2 } &&
          true
        end.each do |n|
          h[n.to_sym] = self.send n.to_sym
        end
        h
      end

      # Returns JSON
      # @return [String] JSON
      # @see #to_hash
      def to_json
        Yajl::Encoder.encode to_hash
      end

      # Initializes the instance.
      # opts values are assigned to properties if exist.
      # @param [Hash] opts
      def initialize opts = {}
        opts.keys.each do |key|
          next  unless respond_to?("#{key}=")
          send("#{key}=", opts[key])
        end
      end
    end
  end
end
