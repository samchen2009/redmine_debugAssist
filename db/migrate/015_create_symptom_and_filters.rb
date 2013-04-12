class CreateSymptomAndFilters < ActiveRecord::Migration
  def change
    create_table :symptom_and_filters do |t|
      t.integer :filter_id
      t.integer :symptom_id
    end
  end
end
