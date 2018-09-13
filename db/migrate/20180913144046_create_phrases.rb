class CreatePhrases < ActiveRecord::Migration[5.2]
  def change
    create_table :phrases do |t|
      t.string :old_string
      t.string :new_string

      t.timestamps
    end
  end
end
