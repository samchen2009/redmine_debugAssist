class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :name
      t.integer :filter_1
      t.integer :filter_2
      t.integer :filter_3
      t.integer :filter_4
      t.integer :filter_5
      t.integer :filter_6
      t.integer :filter_7
      t.integer :filter_8
      t.integer :filter_9
      t.integer :filter_10
      t.integer :score
    end
  end
end
