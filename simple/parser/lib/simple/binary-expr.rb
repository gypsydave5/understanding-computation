class BinaryExpression < Struct.new(:left, :right)
  def inspect
    "«#{self}»"
  end
end

class And < BinaryExpression
  def to_s
    "#{left} && #{right}"
  end

  def evaluate(environment)
    Boolean.new(left.evaluate(environment).value && right.evaluate(environment).value)
  end

end

class LessThan < BinaryExpression
  def to_s
    "#{left} < #{right}"
  end

  def evaluate(environment)
    Boolean.new(left.evaluate(environment).value < right.evaluate(environment).value)
  end
end

class Add < BinaryExpression
  def to_s
    "#{left} + #{right}"
  end

  def evaluate(environment)
    Number.new(left.evaluate(environment).value + right.evaluate(environment).value)
  end
end

class Multiply < BinaryExpression
  def to_s
    "#{left} * #{right}"
  end

  def evaluate(environment)
    Number.new(left.evaluate(environment).value * right.evaluate(environment).value)
  end
end

class Subtract < BinaryExpression
  def to_s
    "#{left} - #{right}"
  end

  def evaluate(environment)
    Number.new(left.evaluate(environment).value - right.evaluate(environment).value)
  end
end

class Divide < BinaryExpression
  def to_s
    "#{left} / #{right}"
  end

  def evaluate(environment)
    Number.new(left.evaluate(environment).value / right.evaluate(environment).value)
  end
end
