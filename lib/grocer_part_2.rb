require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  cart.each do |cart_item|
    
    discount_item = find_item_by_name_in_collection(cart_item[:item], coupons)
    if discount_item
      cart_item[:count] -= discount_item[:num]
      cart << {
        :item => "#{cart_item[:item]} W/COUPON",
        :price => discount_item[:cost] / discount_item[:num],
        :clearance => cart_item[:clearance],
        :count => discount_item[:num]
      }
    end
  end
  return cart
end

def apply_clearance(cart)
  cart.each do |item|
    if item[:clearance]
      item[:price] = (item[:price] * 0.8).round(3)
    end
  end
  return cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  
  # Get total price
  total = 0
  cart.each do |item|
    total += item[:price] * item[:count]
  end
  
  return (total > 100 ? total * 0.9 : total)
end
