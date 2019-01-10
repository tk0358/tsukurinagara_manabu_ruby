require 'date'
require 'pstore'

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
  def initialize(pstore_name)
    # PStoreデータベースファイルを指定して初期化
    @db = PStore.new(pstore_name)
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

    # 作成した蔵書データを1件分をPStoreデータベースに登録する
    @db.transaction do
      @db[key] = book_info
    end
  end

  # 蔵書データの一覧を表示する
  def listAllBookInfos
    puts "\n-----------------------------"
    @db.transaction(true) do
      @db.roots.each do |key|
        puts "キー: #{key}"
        print @db[key].toFormattedString
        puts "\n-----------------------------"
      end
    end
  end

  #蔵書データを削除する
  def delBookInfo
    print "\n"
    print "キーを指定してください: "
    key = gets.chomp

    #　削除対象データを確認してから削除する
    @db.transaction do
      if @db.root?(key)
        print @db[key].toFormattedString
        print "\n削除しますか？(Y/yなら削除を実行します): "
        yesno = gets.chomp.upcase
        if /^Y$/ =~ yesno
          @db.delete(key)
          puts "\nデータベースから削除しました"
        end
      end
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
    @db.transaction(true) do
      @db.roots.each do |key|
        if (book_info.title == "" || book_info.title == @db[key].title) && (book_info.author == "" || book_info.author == @db[key].author) && (book_info.page == 0 || book_info.page == @db[key].page) && (book_info.publish_date == nil || book_info.publish_date == @db[key].publish_date)
          print @db[key].toFormattedString
        end
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
４．蔵書データの削除
９．終了
番号を選んでください（1, 2, 3, 4, 9）: "

      num = gets.chomp
      case
      when '1' == num
        addBookInfo
      when '2' == num
        listAllBookInfos
      when '3' == num
        findBookInfos
      when '4' == num
        delBookInfo
      when '9' == num
        break;
      else
        # 処理待ち画面に戻る
      end
    end
  end
end

# ここからがアプリケーションを動かす本体

# アプリケーションのインスタンスを作る
# 蔵書データのPStoreデータベースを指定している
book_info_manager = BookInfoManager.new("book_info.db")

book_info_manager.run
