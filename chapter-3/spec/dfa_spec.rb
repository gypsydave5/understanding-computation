require 'dfa-rulebook'
require 'fa-rule'
require 'dfa'

describe 'A Deterministic Finate Automata' do

  context 'which has three states and accepts the sequence "ab"' do
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

    it 'can tell whether it is an acceptance state' do
      expect(DFA.new(1, [1, 3], rulebook).accepting?).to be true
      expect(DFA.new(1, [3], rulebook).accepting?).to be false
    end

  end

end
