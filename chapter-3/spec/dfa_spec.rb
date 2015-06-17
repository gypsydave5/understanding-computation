require 'dfa-rulebook'
require 'fa-rule'

describe 'A Deterministic Finate Automata' do

  context 'which has three states' do
      rulebook = DFARulebook.new([
        FARule.new(1, 'a', 2),
        FARule.new(1, 'b', 1),
        FARule.new(2, 'a', 2),
        FARule.new(2, 'b', 3),
        FARule.new(3, 'a', 3),
        FARule.new(3, 'b', 3)
      ])

    it 'knows what the next state is' do
      expect(rulebook.next_state(1, 'a')).to be 2
      expect(rulebook.next_state(1, 'b')).to be 1
      expect(rulebook.next_state(2, 'b')).to be 3
    end

  end

end
