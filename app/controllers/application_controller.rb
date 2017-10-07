require './config/environment'
require 'rack-flash'
class ApplicationController < Sinatra::Base
  use Rack::Flash
  register Sinatra::ActiveRecordExtension
  enable :sessions
  set :session_secret, "my_application_secret"

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'users/create_user'
  end

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

    @user = User.create(params)
    puts @user
    session[:user_id] = @user.id
    redirect to '/'

  end


end
