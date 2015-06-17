require 'simple'

describe 'SIMPLE in small step operational semantics' do

  it 'can add' do
    expression = Add.new(Number.new(1), Number.new(2))
    machine = Machine.new(expression)
    expect(machine.run.statement).to eq Number.new(3)
  end

  it 'can multiply' do
    expression = Multiply.new(Number.new(2), Number.new(2))
    machine = Machine.new(expression)
    expect(machine.run.statement).to eq Number.new(4)
  end

  it 'can subtract' do
    expression = Subtract.new(Number.new(4), Number.new(3))
    machine = Machine.new(expression)
    expect(machine.run.statement).to eq Number.new(1)
  end

  it 'can divide' do
    expression = Divide.new(Number.new(9), Number.new(3))
    machine = Machine.new(expression)
    expect(machine.run.statement).to eq Number.new(3)
  end

  it 'knows AND' do
    expression = And.new(Boolean.new(true), Boolean.new(false))
    machine = Machine.new(expression)
    expect(machine.run.statement).to eq Boolean.new(false)
  end

  it 'knows less than' do
    expression = LessThan.new(Number.new(2), Number.new(5))
    machine = Machine.new(expression)
    expect(machine.run.statement).to eq Boolean.new(true)
  end

  it 'can haz variables' do
    expression = Add.new(Variable.new(:x), Number.new(2))
    machine = Machine.new(expression, { x: Number.new(5) })
    expect(machine.run.statement).to eq Number.new(7)
  end

  it 'can haz multiple variables' do
    expression = Add.new(Variable.new(:x), Variable.new(:y))
    machine = Machine.new(expression, { x: Number.new(5), y: Number.new(2) })
    expect(machine.run.statement).to eq Number.new(7)
  end

  it 'can do assignment' do
    statement = Assign.new(:x, Add.new(Variable.new(:x), Number.new(1)))
    machine = Machine.new(statement, { x: Number.new(2) })
    expect(machine.run.environment[:x]).to eq Number.new(3)
  end

  it 'knows what if means' do
    statement = If.new(Boolean.new(true), Number.new(3), Number.new(5))
    machine = Machine.new(statement)
    expect(machine.run.statement).to eq Number.new(3)
  end

  it 'knows what to do with an if with one consequence' do
    statement = If.new(Boolean.new(false), Number.new(3))
    machine = Machine.new(statement)
    expect(machine.run.statement).to eq DoNothing.new
  end

  it 'can do things in a sequence' do
    statement = Sequence.new(
      Assign.new(:x, Add.new(Number.new(1), Number.new(1))),
      Assign.new(:y, Add.new(Variable.new(:x), Number.new(3)))
    )
    result = Machine.new(statement, {}).run
    expect(result.environment[:x]).to eq Number.new(2)
    expect(result.environment[:y]).to eq Number.new(5)
  end

  it 'can do things in a while loop' do
    statement = Sequence.new(
      Assign.new(:x, Number.new(0)),
      While.new(
        LessThan.new(
          Variable.new(:x), Number.new(5)
        ),
        Assign.new(
          :x,
          Add.new(
            Variable.new(:x),
            Number.new(1)
          )
        )
      )
    )
    result = Machine.new(statement, {}).run
    expect(result.environment[:x]).to eq Number.new(5)
  end
end