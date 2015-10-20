class Blog < ActiveRecord::Base
	has_many :blog_comments
	validates :title, presence: true, length: {minimum: 3 }
	validates :body, presence: true
end
