require 'date'

# 蔵書１冊分の蔵書データのクラスを作る
class BookInfo
  def initialize(title, author, page, publish_date)
    @title = title
    @author = author
    @page = page
    @publish_date = publish_date
  end

  attr_accessor :title, :author, :page, :publish_date

  def to_s
    "#{@title}, #{@author}, #{@page}, #{@publish_date}"
  end

  # 蔵書データを書式をつけて出力
  # 項目の区切り文字を引数に指定できる
  # 引数を省略した場合は改行を区切り文字にする
  def toFormattedString(sep = "\n")
    "書籍名: #{@title}#{sep}著者名: #{@author}#{sep}ページ数: #{@page}ページ#{sep}発刊日: #{publish_date}#{sep}"
  end
end

book_info = BookInfo.new(
  "実践アジャイル　ソフトウェア開発法とプロジェクト管理",
  "山田　正樹",
  248,
  Date.new(2005, 1, 25),
)

puts book_info.to_s

# puts "書籍名: " + book_info.title
# puts "著者名: " + book_info.author
# puts "ページ数: " + book_info.page.to_s + "ページ"
# puts "発刊日: " + book_info.publish_date.to_s

puts book_info.toFormattedString
puts book_info.toFormattedString("/")
