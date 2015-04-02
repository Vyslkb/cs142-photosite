class Photo < ActiveRecord::Base
   has_many :comments
   has_many :tags
   belongs_to :user

   def get_time
      local_time = :date_time.getlocal()
      return local_time.strftime "%Y-%m-%d %H:%M:%S"
   end

   def self.filter(str)
      # if the input string is empty, return no matches
      if (str.nil? || str == "")
         return nil
      end
      results = Set.new
      # get photos with comment text matching the query string
      commentMatches = Comment.where("comment LIKE ?", "%#{str}%")
      commentMatches.each do |comment|
         results.add(comment.photo)
      end
      # get photos with tagged user names matching the query string
      userMatches = User.where("first_name LIKE ?", "%#{str}%")
      userMatches.concat(User.where("last_name LIKE ?", "%#{str}%"))
      userMatches.each do |user|
         user.tags.each do |tag|
            results.add(tag.photo)
         end
      end
      return results
   end
end
