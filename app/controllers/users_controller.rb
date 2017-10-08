class UsersController < ApplicationController

  #BEGIN GET ACTIONS

  get '/signup' do
    erb :'users/create_user'
  end

  get '/login' do
    erb :'users/login'
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end

  get '/profile' do
    if session[:user_id].blank?
      redirect to '/'
    end

    @user = User.find_by(id: session[:user_id])
    @med_array = @user.all_meds
    erb :'users/profile'

  end

  #BEGIN POST ACTIONS

  post '/signup' do

    if (params[:username].blank?)
      flash[:message] = 'Username cannot be blank.'
      redirect to '/signup'
    elsif (params[:password].blank?)
      flash[:message] = 'Password cannot be blank.'
      redirect to '/signup'
    elsif (params[:email].blank?) #to do: validate e-mail format?
      flash[:message] = 'Email cannot be blank.'
      redirect to '/signup'
    end

    #to do: change condition to test these on the fly instead of setting to variables
    @user_name_tester = User.find_by(username: params[:username])
    @user_email_tester = User.find_by(email: params[:email])

    if (@user_name_tester != nil)
      flash[:message] = 'Username taken. Try another username.'
      redirect to '/signup'
    elsif (@user_email_tester != nil)
      flash[:message] = 'The email is already registered. Log in, or use a different email address.'
      redirect to '/signup'
    end

    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    puts @user
    session[:user_id] = @user.id
    redirect to '/' #this needs to redirect somewhere else in the future

  end

  post "/login" do
    @user = User.find_by(:username => params[:username])

    if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to '/'
    else
        flash[:message] = 'Incorrect username or password.'
        redirect to '/login'
    end
  end

end
