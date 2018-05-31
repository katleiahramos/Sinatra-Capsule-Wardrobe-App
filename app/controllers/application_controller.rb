require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    erb :welcome
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "users/#{user.id}"
    else
      redirect '/login'
    end

  end

  get '/users/:id' do
    @user = current_user
    erb :'users/show'
  end


  get '/pieces/new' do
    @user = current_user
    erb :'pieces/create_piece'
  end

  post '/pieces' do
    piece = Piece.create(params)
    redirect "users/#{current_user.id}"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

  end




end
