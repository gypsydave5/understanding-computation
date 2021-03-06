require 'nfa-rulebook'
require 'fa-rule'
require 'nfa'
require 'nfa-design'

describe 'a nondeterministic finite automata' do

  context 'which accepts strings of "a" with a length that is a multiple of 2 or 3' do

    rulebook = NFARulebook.new([
      FARule.new(1, nil, 2),
      FARule.new(1, nil, 4),
      FARule.new(2, 'a', 3),
      FARule.new(3, 'a', 2),
      FARule.new(4, 'a', 5),
      FARule.new(5, 'a', 6),
      FARule.new(6, 'a', 4)
    ])

    it 'knows how to follow free moves' do
      expect(rulebook.follow_free_moves(Set[1])).to eql Set[1, 2, 4]
    end

    it 'reports on acceptance with rules that include freemoves' do
      nfa_design = NFADesign.new(1, [2, 4], rulebook)
      expect(nfa_design.accepts?('aa')).to be true
      expect(nfa_design.accepts?('aaa')).to be true
      expect(nfa_design.accepts?('aaaaa')).to be false
      expect(nfa_design.accepts?('aaaaaa')).to be true
    end
  end
end

