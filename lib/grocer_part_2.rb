require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
=begin
  coupons.each do |index|
    coupon_item_present = find_item_by_name_in_collection(index[:item], cart)
    if coupon_item_present[:count] >= index[:num]
    cart.push ( {:item => "#{index[:item]} W/COUPON",
  :price => (index[:cost] / index[:num]).round(2),
  :clearance => coupon_item_present[:clearance],
  :count => coupon_item_present[:count] - (coupon_item_present[:count] % index[:num])})
    end
    coupon_item_present[:count] -= index[:num]
  end
  cart
=end
i = 0
coupons.each do |coupon|
  item_with_coupon = find_item_by_name_in_collection(coupon[:item], cart)
  item_is_in_basket = !!item_with_coupon
  count_is_big_enough_to_apply = item_is_in_basket && item_with_coupon[:count] >= coupon[:num]
  if item_is_in_basket and count_is_big_enough_to_apply
    cart << { item: "#{item_with_coupon[:item]} W/COUPON", 
              price: coupon[:cost] / coupon[:num], 
              clearance: item_with_coupon[:clearance],
              count: coupon[:num]
            }
    item_with_coupon[:count] -= coupon[:num]
  end
  i += 1
end
cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |index|
    if index[:clearance] == true
      index[:price] = (index[:price] - (index[:price] * 0.20)).round(2)
    end
end
cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers

  consolidated_cart = consolidate_cart(cart)
  coupons_applied = apply_coupons(consolidated_cart, coupons)
  clearance_applied = apply_clearance(coupons_applied)
  total = 0
  clearance_applied.each do |item|
  total += item[:price] * item[:count] 
  end
  if total > 100
    total = total - (total * 0.10)
  end
  total
end
