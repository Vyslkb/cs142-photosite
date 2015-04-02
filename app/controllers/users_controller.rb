class UsersController < ApplicationController
  def index        
    @users = User.all
  end
  def logout       
    reset_session
    flash[:notice] = "You have successfully logged out!"
    redirect_to(:action => :login)
  end
  def new
    @user = User.new()
  end
  def post_login
    user = User.find_by_login(params[:name])
    if (user)
        valid = user.password_valid?(params[:password])
        if (valid) then
            flash[:notice] = "Welcome back " + user.first_name + " " + user.last_name
            session[:user] = user
            redirect_to(:controller => :photos, :action => :index, :id => user.id)
        else
            flash[:notice] = "Login failure. Please try again!"
            redirect_to(:action => :login)
        end
      else
        flash[:notice] = "Login failure. Please try again!"
        redirect_to(:action => :login)
      end
  end
  def create
        user = User.new(:first_name => params[:user][:first_name], :last_name => params[:user][:last_name],
        :login => params[:user][:login], :password => params[:user][:password])
            if user.save
                session[:user] = user
                flash[:notice] = "You have successfully created your account! Welcome!"
                redirect_to(:controller => :photos, :action => :index, :id => user.id)
            else
                flash[:notice] = user.errors.full_messages.to_sentence
                redirect_to(:action => :new)
    end
  end
end
