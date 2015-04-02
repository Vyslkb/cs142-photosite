class User < ActiveRecord::Base
   has_many :comments
   has_many :photos
   has_many :tags
   validates :first_name, :last_name, :login, :password, presence: true, :on => :create
   
   def password
      return @password
   end

   def password=(password)
      @password = password
      self.salt = Random.rand.to_s
      self.password_digest = Digest::SHA1.hexdigest(self.salt + password)
   end

   def password_valid?(password)
      return Digest::SHA1.hexdigest(self.salt + password) == self.password_digest
   end

   def get_name
      return "#{first_name} #{last_name}"
   end
end