class CreateLogFiles < ActiveRecord::Migration
  def change
    create_table :log_files do |t|
      t.string :name
      t.string :ext
      t.integer :product_id
    end
  end
end
