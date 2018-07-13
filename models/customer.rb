require('pg')

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
    @id = options ['id'].to_i = options ['id']
    @name = options ['name']
    @funds = options ['funds']
  end


end
