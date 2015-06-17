require_relative '../binary-expr'

class And < BinaryExpression
  def to_s
    "#{left} && #{right}"
  end

  def reduce(environment)
    return And.new(left.reduce(environment), right) if left.reducible?
    return And.new(left, right.reduce(environment)) if right.reducible?
    Boolean.new(left.value && right.value)
  end

  def evaluate(environment)
    Boolean.new(
      left.evaluate(environment).value && right.evaluate(environment).value
    )
  end

  def to_ruby
    "-> e { (#{left.to_ruby}).call(e) && (#{right.to_ruby}).call(e) }"
  end
end

