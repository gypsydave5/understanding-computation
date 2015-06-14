module Statement
  def statement?
    true
  end

  def inspect
    "«#{self}»"
  end

  def reducible?
    true
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

  def reducible?
    false
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

  def reduce(environment)
    if expression.reducible?
      [Assign.new(name, expression.reduce(environment)), environment]
    else
      [DoNothing.new, environment.merge({ name => expression })]
    end
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

  def reduce(environment)
    if condition.reducible?
      [If.new(condition.reduce(environment), consequence, alternative), environment]
    else
      case condition
      when Boolean.new(true)
        [consequence, environment]
      when Boolean.new(false)
        [alternative, environment]
      end
    end
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

  def reduce(environment)
    if first == DoNothing.new
      [second, environment]
    else
      reduced_first, reduced_environment = first.reduce(environment)
      [Sequence.new(reduced_first, second), reduced_environment]
    end
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

  def reduce(environment)
    [If.new(condition, Sequence.new(body, self), DoNothing.new), environment]
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