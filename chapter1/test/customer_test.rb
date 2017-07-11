require_relative '../src/customer'
require_relative '../src/rental'

require 'minitest/autorun'

describe Customer do
  before do
    @customer = Customer.new('Dummy')
    @normal_movie = Movie.new('Regular', Movie::REGULAR)
    @new_release_movie = Movie.new('New Release', Movie::NEW_RELEASE)
    @children_movie = Movie.new('Children', Movie::CHILDRENS)
  end

  describe '#statement' do
    describe 'with regular movies' do
      it 'has correct info' do
        @customer.add_rental(Rental.new(@normal_movie, 2))
        statement = <<-STATEMENT
Rental Record for Dummy
\tRegular\t2
Amount owed is 2
You earned 1 frequent renter points
        STATEMENT
        @customer.statement.must_equal statement.strip
      end
    end

    describe 'with regular movies rented for more than 2 days' do
      it 'has correct info' do
        @customer.add_rental(Rental.new(@normal_movie, 3))
        statement = <<-STATEMENT
Rental Record for Dummy
\tRegular\t3.5
Amount owed is 3.5
You earned 1 frequent renter points
        STATEMENT
        @customer.statement.must_equal statement.strip
      end
    end

    describe 'with new releases' do
      it 'has correct info' do
        @customer.add_rental(Rental.new(@new_release_movie, 1))
        statement = <<-STATEMENT
Rental Record for Dummy
\tNew Release\t3
Amount owed is 3
You earned 1 frequent renter points
        STATEMENT
        @customer.statement.must_equal statement.strip
      end
    end

    describe 'with new releases rented for more than a day' do
      it 'has correct info' do
        @customer.add_rental(Rental.new(@new_release_movie, 3))
        statement = <<-STATEMENT
Rental Record for Dummy
\tNew Release\t9
Amount owed is 9
You earned 2 frequent renter points
        STATEMENT
        @customer.statement.must_equal statement.strip
      end
    end

    describe 'with children release' do
      it 'has correct info' do
        @customer.add_rental(Rental.new(@children_movie, 2))
        statement = <<-STATEMENT
Rental Record for Dummy
\tChildren\t1.5
Amount owed is 1.5
You earned 1 frequent renter points
        STATEMENT
        @customer.statement.must_equal statement.strip
      end
    end

    describe 'with children releases for more than 3 days' do
      it 'has correct info' do
        @customer.add_rental(Rental.new(@children_movie, 4))
        statement = <<-STATEMENT
Rental Record for Dummy
\tChildren\t3.0
Amount owed is 3.0
You earned 1 frequent renter points
        STATEMENT
        @customer.statement.must_equal statement.strip
      end
    end

    describe 'mixed movies' do
      it 'has correct info' do
        @customer.add_rental(Rental.new(@normal_movie, 3))
        @customer.add_rental(Rental.new(@new_release_movie, 3))
        @customer.add_rental(Rental.new(@children_movie, 4))
        statement = <<-STATEMENT
Rental Record for Dummy
\tRegular\t3.5
\tNew Release\t9
\tChildren\t3.0
Amount owed is 15.5
You earned 4 frequent renter points
        STATEMENT
        @customer.statement.must_equal statement.strip
      end
    end
  end
end
