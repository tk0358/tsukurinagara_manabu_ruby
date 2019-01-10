file = open("sample1.txt", "r:UTF-8")
file.each do |line|
  print line
end
file.close
