require('pg')
require_relative("ticket")
require_relative("film")
require_relative("../db/sql_runner")
require("pry")

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
    @id = options ['id'].to_i if options ['id']
    @name = options ['name']
    @funds = options ['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id =customer['id'].to_i
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE * FROM customers where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def film()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.customer_id WHERE customer_id = $1"
    values = [@id]
    film_info = SqlRunner.run(sql, values)
    result = film_info.map { |film_hash| Film.new(film_hash)}
    return result
  end

  def buy_ticket()
    @funds -= 9
    result = self.update
    print result
  end

end
