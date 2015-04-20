require 'active_record'
require 'pg'

ActiveRecord::Base.establish_connection(
    adapter:  'sqlite3',
    host:     'localhost',
    database: 'db/development.sqlite3'
)

class Group < ActiveRecord::Base

  has_many :products
  accepts_nested_attributes_for :products, :allow_destroy => true

end

class Product < ActiveRecord::Base

  belongs_to :groups

end

product_name = "Product"
puts 'Product\'s group id: '
product_group_id = gets.chomp.to_i

for i in 1..3
  item = Product.new
  item.name = product_name + "_#{i}"
  item.group_id = product_group_id
  item.save
end
