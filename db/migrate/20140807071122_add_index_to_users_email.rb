class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  	# Adding a unique email index to the users table
  	add_index :users, :email, unique: true
  end
end
