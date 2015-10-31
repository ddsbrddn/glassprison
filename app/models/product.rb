class Product < ActiveRecord::Base
	has_many :line_items

	before_destroy :ensure_not_referenced_by_any_line_item

	validates_presence_of :title, :description
	validates_numericality_of :price
	validates_uniqueness_of :title
	validates :image_url, allow_blank: true, format: {
	with:    %r{\.(gif|jpg|png)\Z}i,
	message: 'must be a URL for GIF, JPG or PNG image.'
}

	validates :title, length: {minimum: 3}
	def self.latest
		Product.order(:updated_at).last
	end
private

	# ensure that there are no line items referencing this product
	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base, 'Line Items present')
			return false
		end
	end
end
