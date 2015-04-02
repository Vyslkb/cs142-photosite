class AddPasswordAndSalt < ActiveRecord::Migration
  def change
  	add_column :users, :password_digest, :string
  	add_column :users, :salt, :string
  	User.reset_column_information
	users = User.all
  	users.each do |u| 
  		u.password = u.login
  		u.save
  	end
  end
end
