require_relative '../binary-expr'

class Divide < BinaryExpression
  def to_s
    "#{left} / #{right}"
  end

  def reduce(environment)
    return Divide.new(left.reduce(environment), right) if left.reducible?
    return Divide.new(left, right.reduce(environment)) if right.reducible?
    Number.new(left.value / right.value)
  end

  def evaluate(environment)
    Number.new(
      left.evaluate(environment).value / right.evaluate(environment).value
    )
  end

  def to_ruby
    "-> e { (#{left.to_ruby}).call(e) / (#{right.to_ruby}).call(e) }"
  end
end

