class CreateFilterTypes < ActiveRecord::Migration
  def change
    create_table :filter_types do |t|
      t.string :name
    end
  end
end
