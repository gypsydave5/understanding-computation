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

class Add < Struct.new(:left, :right)
  def to_s
    "#{left} + #{right}"
  end

  def inspect
    "«#{self}»"
  end

  def reducible?
    true
  end

  def reduce
    return Add.new(left.reduce, right) if left.reducible?
    return Add.new(left, right.reduce) if right.reducible?
    Number.new(left.value + right.value)
  end
end

class Multiply < Struct.new(:left, :right)
  def to_s
    "#{left} * #{right}"
  end

  def inspect
    "«#{self}»"
  end

  def reducible?
    true
  end

  def reduce
    return Add.new(left.reduce, right) if left.reducible?
    return Add.new(left, right.reduce) if right.reducible?
    Number.new(left.value * right.value)
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
  end
end