class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :address
      t.string :zip_code
      t.integer :age
      t.string :human_test_one
      t.string :human_test_two
      t.string :human_test_three
      t.string :human_test_four
      
      t.timestamps
    end
  end
end
