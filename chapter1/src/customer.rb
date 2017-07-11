require_relative 'movie.rb'

class Customer
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(arg)
    @rentals << arg
  end

  def statement
    total_amount, frequent_renter_points = 0, 0
    result = "Rental Record for #{name}\n"
    @rentals.each do |rental|
      frequent_renter_points += rental.frequent_renter_points
      total_amount += rental.charge
      result += "\t" + rental.movie.title + "\t" + rental.charge.to_s + "\n"
    end

    result += "Amount owed is #{total_amount}\n"
    result += "You earned #{frequent_renter_points} frequent renter points"
    result
  end
end
