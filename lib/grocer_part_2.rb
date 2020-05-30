# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>START>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


# Green Grocer Part 2
# 053020
# Corey Lynch


#------------------------------------------------------------------------


require_relative './part_1_solution.rb'


#------------------------------------------------------------------------


#format coupon to match cart item format. Takes cart AoH (clearance) and coupon AoH
def itemize(coupon_item, cart_item)
  item_name      = coupon_item[:item] + " W/COUPON"
  item_price     = (coupon_item[:cost] / coupon_item[:num]).round(2)
  item_clearance = cart_item[:clearance]
  item_count     = coupon_item[:num]

 coupon_item = {
  :item      => item_name, 
  :price     => item_price,
  :clearance => item_clearance,
  :count     => item_count
}
  coupon_item
end


#------------------------------------------------------------------------


def apply_coupons(cart, coupons)
  coupon_cart = []

  coupons.each do |coupon_item|
     cart.map { |cart_item|  
      if coupon_item[:item] == cart_item[:item] and coupon_item[:num] <= cart_item[:count] 
        coupon_item = itemize(coupon_item, cart_item)
        
        cart_item[:count] -= coupon_item[:count]
        
        coupon_cart.push(coupon_item)
      end
     }
  end
  coupon_cart.each do |coupon_item|
    cart.push(coupon_item)
  end
  cart
end
   

#------------------------------------------------------------------------


def apply_clearance(cart)
  clearance_cart = []

  cart.map { |cart_item|
    if cart_item[:clearance] == true
      cart_item[:price] -= (cart_item[:price] * 0.2)

      cart_item[:price] = cart_item[:price].round(2)

      clearance_cart.push(cart_item)
    else clearance_cart.push(cart_item)
    
    end
  }
  cart = clearance_cart
  
  cart
end


#------------------------------------------------------------------------


def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  promo_cart        = apply_coupons(consolidated_cart, coupons)
  cart              = apply_clearance(promo_cart)
  cart_total        = 0

  cart.each do |cart_item|
    cart_total += (cart_item[:price] * cart_item[:count])
  end
  
  if cart_total > 100.0
    cart_total -= (cart_total * 0.1)
  end
  cart_total
end


#------------------------------------------------------------------------
















# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>END>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>