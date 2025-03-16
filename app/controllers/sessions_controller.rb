class SessionsController < ApplicationController
  def new
    # render login form in sessions/new.html.erb
  end

  def create
    # authenticate the user
    # Try to find the user by their unique identifier
    @user = User.find_by({"email" => params["email"]})
    # If the user exists -> check if they know their password
    if @user != nil
      # If they know their password -> login is successful
      if BCrypt::Password.new(@user["password"]) == params["password"]
        
        # --- begin user session
        session["user_id"] = @user["id"]

        flash["notice"] = "Welcome."
        redirect_to "/"
      else
        flash["notice"] = "Nope."
        redirect_to "/login"
      end
      # If the user doesn't exist or they don't know their password -> login fails
    else
      flash["notice"] = "Nope."
      redirect_to "/sessions/new"
    end
  end

  def destroy
    # logout the user
    session["user_id"] = nil

    flash["notice"] = "Goodbye."
    redirect_to "/"
  end
end


