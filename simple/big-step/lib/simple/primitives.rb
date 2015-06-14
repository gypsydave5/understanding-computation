class Primitive < Struct.new(:value)
  def to_s
    value.to_s
  end

  def inspect
    "«#{self}»"
  end

  def reducible?
    false
  end

  def evaluate(environment)
    self
  end
end

class Number < Primitive
end

class Boolean < Primitive
end

