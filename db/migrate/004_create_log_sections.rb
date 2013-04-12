class CreateLogSections < ActiveRecord::Migration
  def change
    create_table :log_sections do |t|
      t.string :name
      t.string :start_regexp
      t.string :end_regexp
      t.integer :log_file_id
      t.integer :log_file_id
    end
  end
end
