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


end
