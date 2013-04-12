class CreateSymptomAndRules < ActiveRecord::Migration
  def change
    create_table :symptom_and_rules do |t|
      t.integer :rule_id
      t.integer :symptom_id
    end
  end
end
