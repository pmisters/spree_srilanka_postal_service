class Calculator::SrilankaPostalService < Calculator
  preference :weight_table, :string, :default => "0.5 1 2"
  preference :price_table, :string, :default => "5.09 9.64 19.64"
  preference :max_total_weight, :float, :default => 2
  preference :handling_tax, :float, :default => 2
  
  def self.description
    "Sri Lanka Registered Mail"
  end
  
  def self.register
    super
    ShippingMethod.register_calculator self
  end
  
  def available?(order)
    total_weight = 0
    order.line_items.each do |item|
      total_weight += item.variant.weight * item.quantity
    end
    return false if total_weight > self.preferred_max_total_weight
    return true
  end
  
  def compute(order)
    debug = false
    puts order if debug
    
    total_weight, shipping = 0, 0
    prices = self.preferred_price_table.split.map{ |price| price.to_f }
    puts prices.join(" ") if debug
    
    # determine total weight
    order.line_items.each do |item|
      total_weight += item.variant.weight * item.quantity
    end
    puts "Weight: " + total_weight.to_s if debug
    
    weights = self.preferred_weight_table.split.map{ |weight| weight.to_f }
    puts weights.join(" ") if debug
    index = 0
    weights.each_index do |k|
      index = k
      break if total_weight <= weights[k]
    end
    shipping = prices[index]
    puts "Shipping: " + shipping.to_s if debug
    puts "Handling: " + self.preferred_handling_tax.to_s if debug
    
    return shipping + self.preferred_handling_tax
  end
end