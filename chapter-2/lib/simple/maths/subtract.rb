require_relative '../binary-expr'

class Subtract < BinaryExpression
  def to_s
    "#{left} - #{right}"
  end

  def reduce(environment)
    if left.reducible?
      Subtract.new(left.reduce(environment), right)
    elsif right.reducible?
      Subtract.new(left, right.reduce(environment))
    else
      Number.new(left.value - right.value)
    end
  end

  def evaluate(environment)
    Number.new(
      left.evaluate(environment).value - right.evaluate(environment).value
    )
  end

  def to_ruby
    "-> e { (#{left.to_ruby}).call(e) - (#{right.to_ruby}).call(e) }"
  end
end

