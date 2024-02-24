class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :title
      t.string :genre
      t.string :status
      t.integer :user_id
      t.string :developer
      t.date :release_date
      t.integer :price
      t.text :payment_details

      t.timestamps
    end
  end
end
