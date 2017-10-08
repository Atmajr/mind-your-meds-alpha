require './config/environment'
require 'rack-flash'
require 'date'
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
    if !(session[:user_id].blank?)
      puts "User id =" + session[:user_id].to_s
      @user = User.find_by(id: session[:user_id])
      @username = @user.username
      @logged_in = true
    end
    erb :index
  end

  get '/error' do
    erb :error
  end

end
