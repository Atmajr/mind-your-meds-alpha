class UsersController < ApplicationController

  #BEGIN GET ACTIONS

  get '/signup' do
    flash[:message] = session[:signup].to_s #ridiculous hack to get flash[:message] to persist through this redirect
    session.delete(:signup) #cleaning up hack
    erb :'users/create_user'
  end

  get '/login' do
    flash[:message] = session[:login].to_s
    session.delete(:login)
    erb :'users/login'
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end

  get '/profile' do

    if session[:user_id].blank?
      redirect to '/login'
    end

    @user = User.find_by(id: session[:user_id])
    @med_array = @user.all_meds
    erb :'users/profile'

  end

  #BEGIN POST ACTIONS

  post '/signup' do

    if valid_user?(params) == false
      session[:signup] = flash[:message].to_s #ridiculous hack to get flash[:message] to persist through this redirect
      redirect to '/signup'
    end

    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    puts @user
    session[:user_id] = @user.id
    redirect to '/profile'

  end

  post "/login" do
    @user = User.find_by(:username => params[:username])

    if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to '/'
    else
        flash[:message] = 'Incorrect username or password.'
        session[:login] = flash[:message].to_s #stupid hack for rack flash
        redirect to '/login'
    end
  end

  def valid_user?(user_params)
    if (user_params[:username].blank?)
      flash[:message] = 'Username cannot be blank.'
      return false
    elsif (user_params[:password].blank?)
      flash[:message] = 'Password cannot be blank.'
      return false
    elsif (user_params[:email].blank?) #to do: validate e-mail format?
      flash[:message] = 'Email cannot be blank.'
      return false
    elsif (User.find_by(username: user_params[:username]))
      flash[:message] = 'Username taken. Try another username.'
      return false
    elsif (User.find_by(email: user_params[:email]))
      flash[:message] = 'The email is already registered. Log in, or use a different email address.'
      return false
    elsif (EmailValidator.valid?(user_params[:email].to_s) == false)
      flash[:message] = 'That does not appear to be a valid e-mail address.'
      return false
    else
      return true
    end
  end

end
