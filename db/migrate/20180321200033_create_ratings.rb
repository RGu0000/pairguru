class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.integer :movie_id
      t.integer :user_id
      t.integer :score
      t.timestamps
    end
  end
end
