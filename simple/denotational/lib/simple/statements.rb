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

  def to_ruby
    '-> e { e }'
  end
end

class Assign < Struct.new(:name, :expression)
  include Statement

  def to_s
    "#{name} = #{expression}"
  end

  def to_ruby
    "-> e { e.merge({ #{name.inspect} => (#{expression.to_ruby}).call(e)}) }"
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

  def to_ruby
    """
    -> e {
      if (#{condition.to_ruby}).call(e)
      then (#{consequence.to_ruby}).call(e)
      else (#{alternative.to_ruby}).call(e)
      end
    }
    """
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

  def to_ruby
    "-> e { (#{second.to_ruby}).call((#{first.to_ruby}).call(e)) }"
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

  def to_ruby
    " -> e { while (#{condition.to_ruby}).call(e); e = (#{body.to_ruby}).call(e); end; e}"
  end
end