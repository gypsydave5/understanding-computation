class BinaryExpression < Struct.new(:left, :right)
  def inspect
    "«#{self}»"
  end

  def reducible?
    true
  end

  def statement?
    false
  end
end

class And < BinaryExpression
  def to_s
    "#{left} && #{right}"
  end

  def reduce(environment)
    return And.new(left.reduce(environment), right) if left.reducible?
    return And.new(left, right.reduce(environment)) if right.reducible?
    Boolean.new(left.value && right.value)
  end
end

class Add < BinaryExpression
  def to_s
    "#{left} + #{right}"
  end

  def reduce(environment)
    return Add.new(left.reduce(environment), right) if left.reducible?
    return Add.new(left, right.reduce(environment)) if right.reducible?
    Number.new(left.value + right.value)
  end
end

class Multiply < BinaryExpression
  def to_s
    "#{left} * #{right}"
  end

  def reduce(environment)
    return Multiply.new(left.reduce(environment), right) if left.reducible?
    return Multiply.new(left, right.reduce(environment)) if right.reducible?
    Number.new(left.value * right.value)
  end
end

class Subtract < BinaryExpression
  def to_s
    "#{left} - #{right}"
  end

  def reduce(environment)
    return Subtract.new(left.reduce(environment), right) if left.reducible?
    return Subtract.new(left, right.reduce(environment)) if right.reducible?
    Number.new(left.value - right.value)
  end
end

class Divide < BinaryExpression
  def to_s
    "#{left} / #{right}"
  end

  def reduce(environment)
    return Divide.new(left.reduce(environment), right) if left.reducible?
    return Divide.new(left, right.reduce(environment)) if right.reducible?
    Number.new(left.value / right.value)
  end
end
