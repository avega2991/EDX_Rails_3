class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :group_id
      t.string  :name

      t.timestamps
    end
  end
end
