require 'simple'

describe 'SIMPLE' do

  it 'can add' do
    expression = Add.new(Number.new(1), Number.new(2))
    machine = Machine.new(expression)
    expect(machine.run).to eql Number.new(3)
  end

  it 'can multiply' do
    expression = Multiply.new(Number.new(2), Number.new(2))
    machine = Machine.new(expression)
    expect(machine.run).to eql Number.new(4)
  end

  it 'can subtract' do
    expression = Subtract.new(Number.new(4), Number.new(3))
    machine = Machine.new(expression)
    expect(machine.run).to eql Number.new(1)
  end

  it 'can divide' do
    expression = Divide.new(Number.new(9), Number.new(3))
    machine = Machine.new(expression)
    expect(machine.run).to eql Number.new(3)
  end

  it 'knows AND' do
    expression = And.new(Boolean.new(true), Boolean.new(false))
    machine = Machine.new(expression)
    expect(machine.run).to eql Boolean.new(false)
  end

  it 'can haz variables' do
    expression = Add.new(Variable.new(:x), Variable.new(:y))
    machine = Machine.new(expression, { x: Number.new(5), y: Number.new(2) })
    expect(machine.run).to eql Number.new(7)
  end

end