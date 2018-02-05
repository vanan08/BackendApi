class Content < ApplicationRecord
  def self.formatted_date
    query = <<-SQL
    select contents.id, 
	    contents.title, 
		contents.author, 
		contents.summary, 
		contents.content, 
		contents.state, 
		to_char(published_date, 'DD Mon YYYY HH12:MIam') publish_date
	from contents
	where state = 'published'
    SQL
	self.find_by_sql(query)
  end
end
