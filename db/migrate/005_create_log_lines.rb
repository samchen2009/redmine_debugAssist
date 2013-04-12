class CreateLogLines < ActiveRecord::Migration
  def change
    create_table :log_lines do |t|
      t.string :name
      t.string :regexp
    end
  end
end
