class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.string :digest
      t.string :deck
      t.string :question
      t.string :answer

      t.float :factor, default: 1
      t.integer :schedule, default: 1

      t.timestamps
    end

    add_index :cards, :digest, unique: true
    add_index :cards, :deck
  end
end
