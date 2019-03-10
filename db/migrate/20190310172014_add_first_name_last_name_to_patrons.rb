class AddFirstNameLastNameToPatrons < ActiveRecord::Migration[5.0]
  def change
  	add_column :patrons, :first_name, :string
  	add_column :patrons, :last_name, :string
  end
end
