class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table(:items) do |type|
      type.string(:itemname)
      type.string(:quantity)
    end
  end
end
