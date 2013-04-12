class CreateFilterOutputs < ActiveRecord::Migration
  def change
    create_table :filter_outputs do |t|
      t.string :name
    end
  end
end
