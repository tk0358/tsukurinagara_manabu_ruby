class Student
  def initialize(name, age)
    @name = name
    @age = age
  end

  def name
    @name
  end

  def age
    @age
  end

  def name=(name)
    @name = name
  end

  def age=(age)
    @age = age
  end

  def to_s
    "#{@name}, #{@age}"
  end
end

ruru = Student.new("るる", 7)
akari = Student.new("加勢田あかり", 5)

puts ruru.to_s
puts akari.to_s
