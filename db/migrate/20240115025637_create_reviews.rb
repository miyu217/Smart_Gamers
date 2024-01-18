class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :game_id
      t.integer :rating
      t.text :comment
      t.integer :helpful_count
      t.decimal :spent_amount
      t.string :seriousness_rating
      t.string :package_name

      t.timestamps
    end
  end
end
