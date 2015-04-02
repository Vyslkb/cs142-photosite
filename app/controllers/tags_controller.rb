class TagsController < ApplicationController
  def new
        @tag = Tag.new()
        @photo = Photo.find_by_id(params[:id])
        @users = User.all
    end
    def create
      tag = Tag.new(:photo_id => params[:photo_id], :user_id => params[:tag][:user], 
              :xpos => params[:tag][:xpos], :ypos => params[:tag][:ypos],
                :width => params[:tag][:width], :height => params[:tag][:height],
                :date_time => DateTime.now)
    if tag.save
      flash[:notice] = "You have successfully submitted a tag!"
      redirect_to(:controller => :tags, :action => :new, :id => params[:photo_id])
    else
      flash[:notice] = "Sorry, we were not able to submit your tag!"
      redirect_to(:controller => :tags, :action => :new, :id => params[:photo_id])
    end
  end
end
