class BinaryExpression < Struct.new(:left, :right)
  def to_s
    "#{left} + #{right}"
  end

  def inspect
    "«#{self}»"
  end

  def reducible?
    true
  end
end

class Number < Struct.new(:value)
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

class Add < BinaryExpression
  def reduce
    return Add.new(left.reduce, right) if left.reducible?
    return Add.new(left, right.reduce) if right.reducible?
    Number.new(left.value + right.value)
  end
end

class Multiply < BinaryExpression
  def reduce
    return Multiply.new(left.reduce, right) if left.reducible?
    return Multiply.new(left, right.reduce) if right.reducible?
    Number.new(left.value * right.value)
  end
end

class Subtract < BinaryExpression
  def reduce
    return Subtract.new(left.reduce, right) if left.reducible?
    return Subtract.new(left, right.reduce) if right.reducible?
    Number.new(left.value - right.value)
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