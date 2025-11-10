class AddUnitToItems < ActiveRecord::Migration[8.1]
  def change
    add_column :items, :unit, :string
  end
end
