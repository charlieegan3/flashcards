class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.string :digest

      t.string :deck
      t.string :question
      t.string :answer
      t.integer :score
      t.integer :count

      t.timestamps
    end

    add_index :cards, :digest, unique: true
  end
end
