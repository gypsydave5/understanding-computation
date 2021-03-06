class DFA < Struct.new(:current_state, :accept_states, :rulebook)
  def accepting?
    accept_states.include?(current_state)
  end

  def read_character(character)
    self.current_state = rulebook.next_state(current_state, character)
    self
  end

  def read_string(string)
    string.each_char do |character|
      read_character(character)
    end
    self
  end
end
