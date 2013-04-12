class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :created_by
      t.datetime :created_on
      t.string :descriptions
    end
  end
end
