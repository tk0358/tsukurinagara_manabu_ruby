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

class BookInfoManager
  def initialize
    @book_infos = {}
  end

  def setUp
    @book_infos["Yamada2005"] = BookInfo.new(
      "実践アジャイル　ソフトウェア開発法とプロジェクト管理",
      "山田　正樹",
      248,
      Date.new(2005, 1, 25)
    )
    @book_infos["Ooba2006"] = BookInfo.new(
      "入門LEGO　MINDSTORMS　NXT　レゴブロックで作る動くロボット",
      "大庭　慎一郎",
      164,
      Date.new(2006, 12, 23)
    )
  end

  # 蔵書データを登録する
  def addBookInfo
    # 蔵書データ１件分のインスタンスを作成する
    book_info = BookInfo.new("", "", 0, Date.new)
    print "\n"
    print "キー: "
    key = gets.chomp
    print "書籍名: "
    book_info.title = gets.chomp
    print "著者名: "
    book_info.author = gets.chomp
    print "ページ数: "
    book_info.page = gets.chomp.to_i
    print "発刊年: "
    year = gets.chomp.to_i
    print "発刊月: "
    month = gets.chomp.to_i
    print "発刊日: "
    day = gets.chomp.to_i
    book_info.publish_date = Date.new(year, month, day)

    # 作成した蔵書データの1件分をハッシュに登録する
    @book_infos[key] = book_info
  end

  # 蔵書データの一覧を表示する
  def listAllBookInfos
    puts "\n-----------------------------"
    @book_infos.each do |key, info|
      print info.toFormattedString
    puts "\n-----------------------------"
    end
  end

  # 蔵書データの検索
  def findBookInfos
    book_info = BookInfo.new("", "", 0, nil)
    print "\n"
    print "書籍名: "
    book_info.title = gets.chomp
    print "著者名: "
    book_info.author = gets.chomp
    print "ページ数: "
    book_info.page = gets.chomp.to_i
    print "発刊年: "
    year = gets.chomp.to_i
    print "発刊月: "
    month = gets.chomp.to_i
    print "発刊日: "
    day = gets.chomp.to_i
    if year == 0 || month == 0 || day == 0
      book_info.publish_date = nil
    else
      book_info.publish_date = Date.new(year, month, day)
    end
    @book_infos.each do |key, info|
      if (book_info.title == "" || book_info.title == info.title) && (book_info.author == "" || book_info.author == info.author) && (book_info.page == 0 || book_info.page == info.page) && (book_info.publish_date == nil || book_info.publish_date == info.publish_date)
        print info.toFormattedString
      end
    end
  end

  # 処理の選択と選択後の処理を繰り返す
  def run
    while true
      #機能選択画面を表示する
      print "
１．蔵書データの登録
２．蔵書データの表示
３．蔵書データの検索
９．終了
番号を選んでください（１，２，３，９）: "

      num = gets.chomp
      case
      when '1' == num
        addBookInfo
      when '2' == num
        listAllBookInfos
      when '3' == num
        findBookInfos
      when '9' == num
        break;
      else
        # 処理待ち画面に戻る
      end
    end
  end
end

# アプリケーションのインスタンスを作る
book_info_manager = BookInfoManager.new

book_info_manager.setUp
book_info_manager.run
