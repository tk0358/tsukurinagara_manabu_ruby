class Student
  def initialize(name, age)
    @name = name
    @age = age
  end

  def to_s
    "#{@name}, #{@age}"
  end
end

class StudentBook
  def initialize
    @students = {}
  end

  def setUpStudents
    @students = {
      :shin => Student.new("Shin Kuboki", 45),
      :ruru => Student.new("Ruru Kaseda", 7),
      :momo => Student.new("Momoka Kaseda", 3),
    }
  end

  def printStudents
    @students.each do |key, value|
      puts "#{key} #{value.to_s}"
    end
  end

  def listAllStudents
    setUpStudents
    printStudents
  end
end

student_book = StudentBook.new
student_book.listAllStudents
