class PhotosController < ApplicationController
   def index
      @user = User.find_by_id(params[:id])
      if @user
         @found = true
         @name = @user.first_name + " " + @user.last_name
         @photos = @user.photos.order(date_time: :desc)
      else
         @found = false
         @name = "UserNotFound"
         @photos = nil
      end
   end
   def new
         @photo = Photo.new()
   end
   def create
         uploaded_io = params[:photo][:file]
         File.open(Rails.root.join('app', 'assets', 'images', 
         uploaded_io.original_filename), 'wb') do |file|
               file.write(uploaded_io.read)
         end
         photo = Photo.new(:user_id => session[:user].id, 
            :date_time => DateTime.now, :file_name => uploaded_io.original_filename)
         photo.save
         redirect_to(:action => :index, :id => session[:user].id)
   end
   def search
      @photos = Photo.filter(params[:str]);
      render :json => @photos;
   end
end
