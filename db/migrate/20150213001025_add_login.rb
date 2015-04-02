class AddLogin < ActiveRecord::Migration
  def change
  	add_column :users, :login, :string
  	User.reset_column_information
  	users = User.all
  	users.each do |u| 
  		u.login = u.last_name.downcase
  		u.save
  	end
  end
end
