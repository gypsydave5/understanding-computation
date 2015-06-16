require 'simple'
require 'treetop'

describe 'SIMPLE parser' do

  it 'can parse SIMPLE multiplication and assignment statements' do
    Treetop.load('simple')
    parse_tree = SimpleParser.new.parse('x = 5 * 5')
    statement = parse_tree.to_ast
    expect(statement.evaluate({ x: Number.new(1) })[:x]).to eql Number.new(25)
  end

  it 'can parse SIMPLE while statements' do
    Treetop.load('simple')
    parse_tree = SimpleParser.new.parse('while (x < 5) { x = x * 3 }')
    statement = parse_tree.to_ast
    expect(statement.evaluate({ x: Number.new(1) })[:x]).to eql Number.new(9)
  end

end