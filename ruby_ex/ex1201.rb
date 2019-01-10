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

# 複数の蔵書データを登録する
book_infos = Hash.new
book_infos["Yamada2005"] = BookInfo.new(
  "実践アジャイル　ソフトウェア開発法とプロジェクト管理",
  "山田　正樹",
  248,
  Date.new(2005, 1, 25)
)
book_infos["Ooba2006"] = BookInfo.new(
  "入門LEGO　MINDSTORMS　NXT　レゴブロックで作る動くロボット",
  "大庭　慎一郎",
  164,
  Date.new(2006, 12, 23)
)

book_infos.each do |key, value|
  puts "#{key}: #{value.to_s}"
end
