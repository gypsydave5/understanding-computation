class Primitive < Struct.new(:value)
  def to_s
    value.to_s
  end

  def inspect
    "«#{self}»"
  end

  def to_ruby
    "-> e { #{value.inspect} }"
  end
end

class Number < Primitive
end

class Boolean < Primitive
end

