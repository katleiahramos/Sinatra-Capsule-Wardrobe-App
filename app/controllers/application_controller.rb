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


  get '/signup' do
    erb :'users/create'
  end

  post '/signup' do
    user = User.create(params)
    redirect "/login"
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

  get '/pieces/:id/edit' do
    @piece = Piece.find(params[:id])

    if logged_in? && @piece.user.id == current_user.id
      erb :'pieces/edit_piece'
    elsif logged_in?
      redirect "/users/#{current_user.id}"
    else
      redirect '/'
    end

  end

  patch '/pieces/:id/edit' do
   piece = Piece.find(params[:id])

     params.each do |key, value|
        if !value.empty? && key != "_method"
          piece.update(key => value)
        end
      end

    redirect "/users/#{current_user.id}"
  end


  delete '/pieces/:id/delete' do
    Piece.destroy(params[:id])
    redirect "/users/#{current_user.id}"
  end

  post '/logout' do
    session.destroy
    redirect '/login'
  end

# categories views
  get '/categories/:id' do

    @category = Category.find(params[:id])
    erb :'categories/show_category'
  end


  # pieces views
  get '/pieces/all' do
    @user = current_user
    erb :'pieces/pieces'
  end

  get '/pieces/:id' do
    @piece = Piece.find(params[:id])
    erb :'pieces/show_piece'
  end


  #capsule CRUD
  #UPDATE
  get '/capsule/:id/edit' do
    @capsule = Capsule.find(params[:id])
    erb :'capsule/edit_capsule'
  end

  patch '/capsule/:capsule_id/add/:piece_id' do
    capsule = Capsule.find(params[:capsule_id])
    capsule.pieces << Piece.find(params[:piece_id])
    redirect "/users/#{current_user.id}"
  end

  patch '/capsule/:capsule_id/pieces/:piece_id' do
    capsule = Capsule.find(params[:capsule_id])
    capsule.pieces.delete(Piece.find(params[:piece_id]))
    capsule.save
    redirect "capsule/#{capsule.id}"
  end

  get '/capsule/:id/edit_info' do
    @capsule = Capsule.find(params[:id])
    erb :'capsule/edit_capsule_info'
  end

  patch '/capsule/:id/edit_info' do
    capsule = Capsule.find(params[:id])
    capsule.update(name: params[:name])
    capsule.save
    redirect :"capsule/#{capsule.id}"
  end

  #READ
  get '/capsule/:id' do
    @capsule = Capsule.find(params[:id])

    erb :'capsule/show_capsule'
  end

  #CREATE
  get '/capsule/new' do
    @user = current_user
    erb :'capsule/create_capsule'
  end

  post '/capsule' do
    Capsule.create(params)
    redirect "users/#{current_user.id}"
  end




  #DESTROY
  delete '/capsule/:id/delete' do
    Capsule.destroy(params[:id])
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
