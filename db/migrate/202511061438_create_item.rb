class CreateItem < ActiveRecord::Migration[6.1]
  def change
    create_table(:items) do |t|
      t.string(:itemname)
      t.string(:quantity)
    end
  end
end
