indians = [
  "One little, two little, three little indians\n",
  "Four little, five little, six little Indians\n",
  "Seven little, eight little, nine little Indians\n",
  "Ten little Indian boys\n"
]

file = File.open("sample5.txt", "w:UTF-8")
indians.each do |indian|
  file.print indian
end

file.close

file = open("sample5.txt", "r:UTF-8")
print file.read
file.close
