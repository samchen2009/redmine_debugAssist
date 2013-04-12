class CreateFilterOutputCaps < ActiveRecord::Migration
  def change
    create_table :filter_output_caps do |t|
      t.integer :filter_id
      t.integer :filter_output_id
    end
  end
end
