# frozen_string_literal: true

module Typemaster
  class StructValue < ActiveRecord::Type::Json
    def initialize(struct_class)
      @struct_class = struct_class
    end

    def serialize(val)
      return super if val.nil?

      super(@struct_class.new(val.to_h.deep_symbolize_keys))
    end

    def deserialize(db_value)
      hash = super(db_value)

      return if hash.nil?

      @struct_class.new(hash.deep_symbolize_keys)
    end
  end
end
