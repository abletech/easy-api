class User
  attr_reader :age, :name

  def initialize(name, age)
    @name = name
    @age = age
  end

  def to_xml
    "<?xml version=\"1.0\" encoding=\"UTF-8\"?><user><id type=\"integer\">1</id><name>#{@name}</name><age type=\"integer\">#{age}</age></user>"
  end

end
