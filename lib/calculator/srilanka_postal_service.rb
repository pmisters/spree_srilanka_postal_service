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
    total_weight, shipping = 0, 0
    # determine total weight
    order.line_items.each do |item|
      total_weight += item.variant.weight * item.quantity
    end
    return calculate_price_for(total_weight)
  end
  
  def calculate_price_for(weight)
    prices = self.preferred_price_table.split.map{ |price| price.to_f }
    weights = self.preferred_weight_table.split.map{ |w| w.to_f }
    index = 0
    weights.each_index do |k|
      index = k
      break if weight <= weights[k]
    end
    shipping = prices[index]
    return shipping + self.preferred_handling_tax
  end
end