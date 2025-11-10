class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table(:users) do |type|
      type.string(:username)
      type.string(:password)
    end
  end
end
