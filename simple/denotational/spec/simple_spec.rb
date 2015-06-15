require 'simple'

describe 'SIMPLE' do

  it 'can add' do
    expression = Add.new(Number.new(1), Number.new(2))
    expect(eval(expression.to_ruby).call({})).to eq 3
  end

  it 'can multiply' do
    expression = Multiply.new(Number.new(2), Number.new(2))
    expect(eval(expression.to_ruby).call({})).to eq 4
  end

  it 'can subtract' do
    expression = Subtract.new(Number.new(4), Number.new(3))
    expect(eval(expression.to_ruby).call({})).to eq 1
  end

  it 'can divide' do
    expression = Divide.new(Number.new(9), Number.new(3))
    expect(eval(expression.to_ruby).call({})).to eq 3
  end

  it 'knows AND' do
    expression = And.new(Boolean.new(true), Boolean.new(false))
    expect(eval(expression.to_ruby).call({})).to eq false
  end

  it 'knows less than' do
    expression = LessThan.new(Number.new(2), Number.new(5))
    expect(eval(expression.to_ruby).call({})).to eq true
  end

  it 'can haz variables' do
    expression = Add.new(Variable.new(:x), Number.new(2))
    expect(eval(expression.to_ruby).call({
      x: 5
    })).to eq 7
  end

  it 'can haz multiple variables' do
    expression = Add.new(Variable.new(:x), Variable.new(:y))
    expect(eval(expression.to_ruby).call({
      x: 2,
      y: 5
    })).to eq 7
  end

  it 'can do assignment' do
    statement = Assign.new(:x, Add.new(Variable.new(:x), Number.new(1)))
    expect(eval(statement.to_ruby).call({
      x: 2
    })[:x]).to eq 3
  end

  it 'knows what if means' do
    statement = If.new(Boolean.new(true), Number.new(3), Number.new(5))
    expect(eval(statement.to_ruby).call({})).to eq 3
  end

  it 'knows what to do with an if with one consequence' do
    statement = If.new(Boolean.new(false), Number.new(3))
    expect(eval(statement.to_ruby).call({})).to eq({})
  end

  it 'can do things in a sequence' do
    statement = Sequence.new(
      Assign.new(:x, Add.new(Number.new(1), Number.new(1))),
      Assign.new(:y, Add.new(Variable.new(:x), Number.new(3)))
    )
    result = eval(statement.to_ruby).call({})
    expect(result[:x]).to eq 2
    expect(result[:y]).to eq 5
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
    puts statement.to_ruby
    result = eval(statement.to_ruby).call({})
    expect(result[:x]).to eq 5
  end
end