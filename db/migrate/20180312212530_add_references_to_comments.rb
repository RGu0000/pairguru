class AddReferencesToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :movie_id, :integer
    add_index :comments, :movie_id
    add_column :comments, :author_id, :integer
    add_index :comments, :author_id
  end
end
