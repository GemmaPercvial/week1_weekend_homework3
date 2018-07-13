require('pg')

class Ticket

  attr_accessor :customer_id, :film_id
  attr_reader :id

  def initialize(options)
    @id = options ['id'].to_i = options ['id']
    @customer_id = options ['customer_id']
    @film_id = options ['film_id']
  end



end
