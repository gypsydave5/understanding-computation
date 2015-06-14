module Statement
  def statement?
    true
  end

  def inspect
    "«#{self}»"
  end
end

class DoNothing
  include Statement

  def to_s
    'do-nothing'
  end

  def ==(other_statement)
    other_statement.instance_of?(DoNothing)
  end

  def evaluate(environment)
    environment
  end
end

class Assign < Struct.new(:name, :expression)
  include Statement

  def to_s
    "#{name} = #{expression}"
  end

  def evaluate(environment)
    environment.merge({ name => expression.evaluate(environment) })
  end
end

class If < Struct.new(:condition, :consequence, :alternative)
  include Statement

  def initialize(condition, consequence, alternative = DoNothing.new)
    super
  end

  def to_s
    "if (#{condition}) { #{consequence} } else { #{alternative} }"
  end

  def evaluate(environment)
    case condition.evaluate(environment)
    when Boolean.new(true)
      consequence.evaluate(environment)
    when Boolean.new(false)
      alternative.evaluate(environment)
    end
  end
end

class Sequence < Struct.new(:first, :second)
  include Statement

  def to_s
    "#{first}; #{second}"
  end

  def evaluate(environment)
    second.evaluate(first.evaluate(environment))
  end
end

class While < Struct.new(:condition, :body)
  include Statement

  def to_s
    "while (#{condition}) { #{body} }"
  end

  def evaluate(environment)
    case condition.evaluate(environment)
    when Boolean.new(true)
      evaluate(body.evaluate(environment))
    when Boolean.new(false)
      environment
    end
  end
end