class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :real_gender
      t.string :dead_name
      t.string :real_name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :court_address
      t.string :court_location
      t.string :court_name
      t.date :dob
      t.string :born
      t.string :telephone
      t.datetime :delivered_at
      t.string :email

      t.timestamps
    end
  end
end
