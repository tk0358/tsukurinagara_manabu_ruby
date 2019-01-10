class Student
  def initialize(name, age)
    @name = name
    @age = age
  end

  def to_s
    "#{@name}, #{@age}"
  end
end

students = {
  :shin => Student.new("Shin Kuboki", 45),
  :ruru => Student.new("Ruru Kaseda", 7),
  :momo => Student.new("Momoka Kaseda", 3),
}

students.each do |key, value|
  puts "#{key} #{value.to_s}"
end
