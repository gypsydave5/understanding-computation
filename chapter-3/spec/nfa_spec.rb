require 'nfa-rulebook'
require 'fa-rule'
require 'nfa'
require 'nfa-design'

describe 'a nondeterministic finite automata' do

  context 'which accepts strings where the third from last character is "b"' do

    rulebook = NFARulebook.new([
      FARule.new(1, 'a', 1),
      FARule.new(1, 'b', 1),
      FARule.new(1, 'b', 2),
      FARule.new(2, 'a', 3),
      FARule.new(2, 'b', 3),
      FARule.new(3, 'a', 4),
      FARule.new(3, 'b', 4)
    ])

    it 'knows what the next state is' do
      expect(rulebook.next_states(Set[1], 'b')).to eql Set[1, 2]
      expect(rulebook.next_states(Set[1, 2], 'b')).to eql Set[1, 2, 3]
      expect(rulebook.next_states(Set[1, 2], 'a')).to eql Set[1, 3]
      expect(rulebook.next_states(Set[1, 3], 'b')).to eql Set[1, 2, 4]
      expect(rulebook.next_states(Set[1, 3], 'a')).to eql Set[1, 4]
    end

    it 'knows the current state of the automata' do
      expect(NFA.new(Set[1], [4], rulebook).accepting?).to be false
      expect(NFA.new(Set[1, 2, 4], [4], rulebook).accepting?).to be true
    end

    it 'knows how to read a character' do
      nfa = NFA.new(Set[1], [4], rulebook)
      nfa.read_character('b').read_character('a').read_character('b')
      expect(nfa.accepting?).to be true
    end

    it 'knows how to read a string' do
      nfa = NFA.new(Set[1], [4], rulebook).read_string('babbbab')
      expect(nfa.accepting?).to be true
    end

    it 'can report on the acceptability of strings' do
      nfa_design = NFADesign.new(1, [4], rulebook)
      expect(nfa_design.accepts?('abb')).to be false
      expect(nfa_design.accepts?('babbbbab')).to be true
    end

  end
end
