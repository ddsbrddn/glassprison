class Product < ActiveRecord::Base
	validates_presence_of :title, :description
	validates_numericality_of :price
	validates_uniqueness_of :title
end
