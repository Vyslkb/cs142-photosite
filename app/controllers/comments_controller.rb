class CommentsController < ApplicationController
    def new
        @comment = Comment.new
        @photo = Photo.find_by_id(params[:id])
        if @photo
            @found = true
            @name = "Photo Comment Page"
        else
            @found = false
            @name = "Photo Not Found"
        end
    end
    def create
        comment = Comment.new(:date_time => DateTime.now, 
                              :comment => params[:comment][:comment], 
                              :user_id => session[:user].id,
                              :photo_id => params[:id])
        comment.save
        photo = Photo.find_by_id(params[:id])
        redirect_to(:controller => :photos, :action => :index, :id => photo.user_id)
    end
end
