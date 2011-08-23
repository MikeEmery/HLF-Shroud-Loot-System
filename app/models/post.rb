class Post < ActiveRecord::Base
	
	has_many :comments
	belongs_to :user
	
	def parsed_body
		parser = RbbCode::Parser.new
		parser.parse(read_attribute(:body)).html_safe
	end
end
