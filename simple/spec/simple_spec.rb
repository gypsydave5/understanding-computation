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

end