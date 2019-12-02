class AddCountToCards < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :count, :integer, default: 0
  end
end
