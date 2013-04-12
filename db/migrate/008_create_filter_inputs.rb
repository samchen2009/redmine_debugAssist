class CreateFilterInputs < ActiveRecord::Migration
  def change
    create_table :filter_inputs do |t|
      t.string :name
    end
  end
end
