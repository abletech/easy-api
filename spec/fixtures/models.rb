class User
  attr_reader :age, :name

  def initialize(name, age)
    @name = name
    @age = age
  end

  def to_xml(options = {})
    require 'builder'
    options[:indent] ||= 2
    xml = options[:builder] ||= ::Builder::XmlMarkup.new(indent: options[:indent])
    xml.instruct! unless options[:skip_instruct]
    xml.user do
      xml.tag!(:name, name)
      xml.tag!(:age, age)
    end
  end
end

class Customer
  attr_reader :age, :name

  def initialize(name, age)
    @name = name
    @age = age
  end

  def to_xml(options = {})
    require 'builder'
    xml = options[:builder] ||= ::Builder::XmlMarkup.new(indent: options[:indent])
    xml.instruct! unless options[:skip_instruct]
    xml.customer do
      xml.tag!(:name, name)
      xml.tag!(:age, age)
    end
  end
end
