require './config/environment'
require 'rack-flash'
class ApplicationController < Sinatra::Base


  use Rack::Flash

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
    if logged_in?
      flash[:message] = "You are already logged in."
      redirect :"users/#{current_user.id}"
    else
    erb :login
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user  && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "users/#{user.id}"
    else
      flash[:message] = "Username/Password incorrect or not found. Please Try again."
      redirect '/login'
    end

  end


  get '/signup' do
    if logged_in?
      flash[:message] = "You are already logged in."
      redirect :"users/#{current_user.id}"
    else
      erb :'users/create'
    end
  end

  post '/signup' do
    # validate that username and email are not already in use.
    if User.find_by(username: params[:username])
      flash[:message] = "User already exists. Please try again or log in."
      redirect '/signup'
    elsif User.find_by(email: params[:email])
      flash[:message] = "E-mail already in use. Please enter a new e-mail or log in."
      redirect '/signup'
    else
      #create user if username and email are not already in use.
      user = User.create(params)
      flash[:message] = "User created successfully. Please log in."
      redirect '/login'
    end

  end

  get '/users/:id' do

    if logged_in? && current_user.id == params[:id].to_i
      @user = current_user
      erb :'users/show'
    elsif logged_in?
      # user restriction on user page
      flash[:message] = "Access Restricted."
      redirect :"users/#{current_user.id}"
    else

      flash[:message] = "Access restricted. Please log in."
      redirect :'/'
    end
  end




  get '/pieces/new' do
    # piece can only be created by users that are logged in
    if logged_in?
      @user = current_user
      erb :'pieces/create_piece'
    else
      flash[:message] = "Access restricted. Please log in."
      redirect :'/'
    end
  end

  post '/pieces' do
    piece = Piece.create(params)
    flash[:message] = "Piece created successfully."
    redirect "users/#{current_user.id}"
  end

  #edit an individual piece
  get '/pieces/:id/edit' do
    @piece = Piece.find(params[:id])

    if logged_in? && @piece.user.id == current_user.id
      erb :'pieces/edit_piece'
    elsif logged_in?
      flash[:message] = "Access restricted."
      redirect "/users/#{current_user.id}"
    else
      flash[:message] = "Please Log-in."
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

  #delete an individual piece
  delete '/pieces/:id/delete' do
    Piece.destroy(params[:id])
    redirect "/users/#{current_user.id}"
  end

  post '/logout' do
    session.destroy
    flash[:message] = "You have successfully logged out."
    redirect '/'
  end




  # pieces views

  #view individual piece
  get '/pieces/:id' do
    @piece = Piece.find(params[:id])
    if logged_in? && @piece.user.id == current_user.id
      erb :'pieces/show_piece'
    elsif logged_in?
      flash[:message] = "Access restricted."
      redirect "/users/#{current_user.id}"
    else
      flash[:message] = "Please Log-in."
      redirect '/'
    end

  end


  #capsule CRUD
  #UPDATE



  #add to capsule
  patch '/capsule/:capsule_id/add/:piece_id' do
    capsule = Capsule.find(params[:capsule_id])

    if capsule.pieces.include?(Piece.find(params[:piece_id]))
      flash[:message] = "Piece is already in the capsule."
      redirect "/users/#{current_user.id}"
    else
      capsule.pieces << Piece.find(params[:piece_id])
      flash[:message] = "Piece successfully added to capsule."
      redirect "/users/#{current_user.id}"
    end
  end


  #remove from capsule
  patch '/capsule/:capsule_id/pieces/:piece_id' do
    capsule = Capsule.find(params[:capsule_id])
    capsule.pieces.delete(Piece.find(params[:piece_id]))
    capsule.save
    flash[:message] = "Piece successfully removed from capsule."
    redirect "users/#{current_user.id}"
  end

  get '/capsule/:id/edit_info' do
    @capsule = Capsule.find(params[:id])
    erb :'capsule/edit_capsule_info'
  end

  patch '/capsule/:id/edit_info' do
    capsule = Capsule.find(params[:id])
    capsule.update(name: params[:name])
    capsule.save
    flash[:message] = "Capsule successfully updated."
    redirect :"users/#{current_user.id}"
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
    flash[:message] = "Capsule successfully deleted."
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
