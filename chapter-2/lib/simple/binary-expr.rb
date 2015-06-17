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

