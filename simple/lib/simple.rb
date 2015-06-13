class BinaryExpression < Struct.new(:left, :right)
  def inspect
    "«#{self}»"
  end

  def reducible?
    true
  end
end

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
end

class Number < Primitive
end

class Boolean < Primitive
end

class And < BinaryExpression
  def to_s
    "#{left} && #{right}"
  end

  def reduce
    return And.new(left.reduce, right) if left.reducible?
    return And.new(left, right.reduce) if right.reducible?
    Boolean.new(left.value && right.value)
  end
end

class Add < BinaryExpression
  def to_s
    "#{left} + #{right}"
  end

  def reduce
    return Add.new(left.reduce, right) if left.reducible?
    return Add.new(left, right.reduce) if right.reducible?
    Number.new(left.value + right.value)
  end
end

class Multiply < BinaryExpression
  def to_s
    "#{left} * #{right}"
  end

  def reduce
    return Multiply.new(left.reduce, right) if left.reducible?
    return Multiply.new(left, right.reduce) if right.reducible?
    Number.new(left.value * right.value)
  end
end

class Subtract < BinaryExpression
  def to_s
    "#{left} - #{right}"
  end

  def reduce
    return Subtract.new(left.reduce, right) if left.reducible?
    return Subtract.new(left, right.reduce) if right.reducible?
    Number.new(left.value - right.value)
  end
end

class Divide < BinaryExpression
  def to_s
    "#{left} / #{right}"
  end

  def reduce
    return Divide.new(left.reduce, right) if left.reducible?
    return Divide.new(left, right.reduce) if right.reducible?
    Number.new(left.value / right.value)
  end
end

class Machine < Struct.new(:expression)
  def step
    self.expression = expression.reduce
  end

  def run
    while expression.reducible?
      puts expression
      step
    end

    puts expression
    expression
  end
end