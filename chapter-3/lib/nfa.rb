class NFA < Struct.new(:current_states, :accept_states, :rulebook)
  def accepting?
    (current_states & accept_states).any?
  end

  def read_character(character)
    self.current_states = rulebook.next_states(current_states, character)
    self
  end

  def read_string(string)
    string.each_char { |character| read_character(character) }
    self
  end

  def current_states
    rulebook.follow_free_moves(super)
  end
end

