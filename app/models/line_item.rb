class LineItem < ActiveRecord::Base
	#belongs_to :order
	belongs_to :product
	belongs_to :cart
	def total_price
		product.price * quantity
	end

	def quantity
    @cart = Cart.all.count
  end

end
