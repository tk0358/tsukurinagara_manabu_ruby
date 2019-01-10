require 'rubygems'
require 'dbi'
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
  def initialize(sqlite_name)
    # SQLite3データベースファイルに接続
    @db_name = sqlite_name
    @dbh = DBI.connect("DBI:SQLite3:#{@db_name}")
  end

  # 蔵書データベースを初期化する
  def initBookInfos
    puts "\n0. 蔵書データベースの初期化"
    print "初期化しますか？(Y/yなら削除を実行します): "
    yesno = gets.chomp.upcase
    if /^Y$/ =~ yesno
      # もしすでにこのデータベースにテーブル'bookinfos'があれば削除する
      @dbh.do("drop table if exists bookinfos")

      # 新しく'bookinfos'テーブルを作成する
      @dbh.do("create table bookinfos (
        id varchar(50)  not null,
        title varchar(100)  not null,
        author varchar(100)  not null,
        page int  not null,
        publish_date datetime  not null,
        primary key(id));")
      puts "\nデータベースを初期化しました。"
    end
  end

  # 蔵書データを登録する
  def addBookInfo
    puts "\n1. 蔵書データの登録"
    print "蔵書データを登録します。"

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
    @dbh.do("insert into bookinfos values (
      \'#{key}\',
      \'#{book_info.title}\',
      \'#{book_info.author}\',
      #{book_info.page},
      \'#{book_info.publish_date}\');")
    puts "\n登録しました。"
  end

  # 蔵書データの一覧を表示する
  def listAllBookInfos
    # テーブル上の項目名を日本語に変えるハッシュテーブル
    item_name = {
      'id' => "キー",
      'title' => "書籍名",
      'author' => "著者名",
      'page' => "ページ数",
      'publish_date' => "発刊日"
    }
    puts "\n2.蔵書データの表示"
    print "蔵書データを表示します。"

    puts "\n-----------------------------"

    # デーブルからデータを読み込んで表示する
    sth = @dbh.execute("select * from bookinfos")

    # select文の実行結果を１行ずつrowに取り出し、繰り返し処理する
    counts = 0
    sth.each do |row|
      # rowは１件分のデータを保持しているので、
      # each_with_nameメソッドで値と項目名を取り出して表示する
      row.each_with_name do |val, name|
        puts "#{item_name[name]}: #{val.to_s}"
      end
      puts "---------------------------------"
      counts += 1
    end

    sth.finish
    puts "\n#{counts}件表示しました。"
  end

  def defBookInfo
    puts
    print "キーを指定してください："
    key = gets.chomp
    sth = @dbh.execute("select * from bookinfos where id=\'#{key}\'")
    sth.each do |row|
      row.each_with_name do |val, name|
        puts "#{name}: #{val}"
      end
    end
    sth.finish
    print "\n削除しますか？(Y/yなら削除を実行します): "
    yesno = gets.chomp.upcase
    if /^Y$/ =~ yesno
      sth = @dbh.execute("delete from bookinfos where id=\'#{key}\'")
      puts "\nデータベースから削除しました。"
      sth.finish
    end
  end

  # 処理の選択と選択後の処理を繰り返す
  def run
    while true
      #機能選択画面を表示する
      print "
0. 蔵書データベースの初期化
1. 蔵書データの登録
2. 蔵書データの表示
3. 蔵書データの削除
9. 終了
番号を選んでください(0, 1, 2, 9): "

      num = gets.chomp
      case
      when '0' == num
        initBookInfos
      when '1' == num
        addBookInfo
      when '2' == num
        listAllBookInfos
      when '3' == num
        defBookInfo
      when '9' == num
        # データベースとの接続を終了する
        @dbh.disconnect
        # アプリケーションの終了
        puts "\n終了しました。"
        break;
      else
        # 処理待ち画面に戻る
      end
    end
  end
end

# ここからがアプリケーションを動かす本体

# アプリケーションのインスタンスを作る
# 蔵書データのSQLite3のデータベースを指定している
book_info_manager = BookInfoManager.new("bookinfo_sqlite.db")

book_info_manager.run
