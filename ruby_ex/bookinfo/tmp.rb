dbh.do("update bookinfos set \　
  title='#{req.query['title']}',author='#{req.query['author']}',\
  page='#{req.query['page']}',publish_date='#{req.query['publish_date']}'\
  where id='#{req.query['id']}';")
