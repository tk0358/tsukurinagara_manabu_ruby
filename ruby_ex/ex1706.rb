open("sample1.txt", "r:UTF-8") do |file|
  file.each do |line|
    print line
  end
end
