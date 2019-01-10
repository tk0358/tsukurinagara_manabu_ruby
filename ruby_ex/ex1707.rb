fruits = %w(apple banana cherry fig grape)

#ファイル名を変数に割り当てる
fname = "sample7.txt"

open(fname, "w:UTF-8"){ |file|
  fruits.each{|fruit| file.puts fruit}
}

open(fname, "r:UTF-8") {|file|
  file.each do |line|
    print line
  end
}

File.delete(fname)
open(fname, "r:UTF-8"){|file|

}
