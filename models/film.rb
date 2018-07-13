require('pg')
require("pry")
require_relative("../db/sql_runner")
require_relative("ticket")
require_relative("customer")

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @id = options ['id'].to_i if options ['id']
    @title = options ['title']
    @price = options ['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE * FROM films where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customer()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.film_id WHERE film_id = $1"
    values = [@id]
    customer_info = SqlRunner.run(sql, values)
    result = customer_info.map { |customer_hash| Customer.new(customer_hash)}
    return result
  end

end
