class Machine < Struct.new(:statement, :environment)
  def step
    if statement.statement?
      self.statement, self.environment = statement.reduce(environment)
    else
      self.statement = statement.reduce(environment)
    end
  end

  def run
    while statement.reducible?
      puts "#{statement}, #{environment}"
      step
    end

    puts "#{statement}, #{environment}"
    self
  end
end
