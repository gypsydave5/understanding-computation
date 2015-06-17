require_relative '../binary-expr'

class Multiply < BinaryExpression
  def to_s
    "#{left} * #{right}"
  end

  def reduce(environment)
    return Multiply.new(left.reduce(environment), right) if left.reducible?
    return Multiply.new(left, right.reduce(environment)) if right.reducible?
    Number.new(left.value * right.value)
  end

  def evaluate(environment)
    Number.new(
      left.evaluate(environment).value * right.evaluate(environment).value
    )
  end

  def to_ruby
    "-> e { (#{left.to_ruby}).call(e) * (#{right.to_ruby}).call(e) }"
  end
end


