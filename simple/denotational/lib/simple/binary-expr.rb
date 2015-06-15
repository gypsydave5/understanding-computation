class BinaryExpression < Struct.new(:left, :right)
  def inspect
    "«#{self}»"
  end
end

class And < BinaryExpression
  def to_s
    "#{left} && #{right}"
  end

  def to_ruby
    "-> e { (#{left.to_ruby}).call(e) && (#{right.to_ruby}).call(e) }"
  end
end

class LessThan < BinaryExpression
  def to_s
    "#{left} < #{right}"
  end

  def to_ruby
    "-> e { (#{left.to_ruby}).call(e) < (#{right.to_ruby}).call(e) }"
  end
end

class Add < BinaryExpression
  def to_s
    "#{left} + #{right}"
  end

  def to_ruby
    "-> e { (#{left.to_ruby}).call(e) + (#{right.to_ruby}).call(e) }"
  end
end

class Multiply < BinaryExpression
  def to_s
    "#{left} * #{right}"
  end

  def to_ruby
    "-> e { (#{left.to_ruby}).call(e) * (#{right.to_ruby}).call(e) }"
  end
end

class Subtract < BinaryExpression
  def to_s
    "#{left} - #{right}"
  end

  def to_ruby
    "-> e { (#{left.to_ruby}).call(e) - (#{right.to_ruby}).call(e) }"
  end
end

class Divide < BinaryExpression
  def to_s
    "#{left} / #{right}"
  end

  def to_ruby
    "-> e { (#{left.to_ruby}).call(e) / (#{right.to_ruby}).call(e) }"
  end
end
