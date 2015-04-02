class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
    	t.string	:photo_id
    	t.string	:user_id
      t.integer	:xpos
      t.integer	:ypos
      t.integer	:width
      t.integer	:height
      t.datetime	:date_time
    end
  end
end
