require 'sinatra'
require 'sinatra/reloader'
also_reload 'inventory_db.rb'
require_relative 'inventory_db'
require_relative 'user_db'
require 'securerandom'

enable :sessions
set :session_secret, SecureRandom.hex(64)

inventory_db = InventoryDB.new
user_db = UserDB.new

unless user_db.exists?('admin')
  user_db.create_user('admin', 'admin123')
end

helpers do
  def current_user
    session[:user]
  end

  def logged_in?
    !current_user.nil?
  end

  def require_login!
    redirect '/login' unless logged_in?
  end
end

get '/' do
    @message = params[:message]
    if session[:user]
        @welcome = "Welcome #{session[:user]}! This is an Inventory System."
    else
        @welcome = "Welcome to the Inventory System!"
    end
    erb :index
end


get '/view' do
    @items = inventory_db.items
    @quantities = inventory_db.quantities
    erb :view
end

get '/add' do
    require_login!
    @message = params[:message]
    erb :add
end

post '/add' do
    require_login!
    normalized_item = params[:item].strip.upcase
    quantity = params[:quantity].to_i
    
    inventory_db.add(normalized_item, quantity)
    redirect "/add?message=Added+#{quantity}+#{normalized_item}"
end

get '/batch' do
    require_login!
    erb :batch
end

post '/batch' do
    require_login!
    items = params[:batch_item] || []
    quantities = params[:batch_quantity] || []

    normalized_items = items.map { |i| i.strip.upcase }
    normalized_quantities = quantities.map(&:to_i)

    inventory_db.batch(normalized_items, normalized_quantities)
    redirect '/view'
end

get '/edit/:item' do
    require_login!
    @item = params[:item]
    index = inventory_db.items.find_index(@item)
    if index.nil?
      redirect '/view'
    else
      @quantity = inventory_db.quantities[index]
      erb :edit
    end
end

post '/edit/:item' do
    require_login!
    item = params[:item]
    new_quantity = params[:quantity].to_i
    inventory_db.edit(item, new_quantity)
    redirect '/view'
end

post '/delete/:item' do
    require_login!
    item = params[:item]
    inventory_db.delete(item)
    redirect '/view'
end

get '/signup' do
    erb :signup
end

post '/signup' do
    username = params[:username].to_s
    password = params[:password].to_s
    if user_db.exists?(username)
        @signup_error = "Username already exists."
        erb :signup
    else
        if user_db.create_user(username, password)
            session[:user] = username
            redirect '/'
        else
            @signup_error = "Invalid username or password."
            erb :signup
        end
    end
end

get '/login' do
    erb :login
end

post '/login' do
    username = params[:username].to_s
    password = params[:password].to_s
    if user_db.authenticate(username, password)
        session[:user] = username
        redirect '/?message=Log+in+Successfully.'

    else
        @login_error = "Invalid username or password"
        erb :login
    end
end

get '/logout' do
    session.clear
    redirect '/?message=Log+out+Successfully.'
end
