class CreateLogLineFields < ActiveRecord::Migration
  def change
    create_table :log_line_fields do |t|
      t.string :name
      t.integer :log_line_id
      t.integer :position
    end
  end
end
