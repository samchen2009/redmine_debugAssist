class CreateFilterInputCaps < ActiveRecord::Migration
  def change
    create_table :filter_input_caps do |t|
      t.integer :filter_id
      t.integer :filter_input_id
    end
  end
end
