enable :sessions

get '/' do
@users = User.all
erb :index
end
#----------- SESSIONS -----------
get '/sessions/new' do
  erb :sign_in
end

post '/sessions' do
  user = User.authenticate(params[:email], params[:password])
  if user
    start_session(user)
    redirect '/'
  end
  redirect'/'
end

delete '/sessions/:id' do
  session.clear
  redirect "/"
end

#----------- USERS -----------

get '/users/new' do
  erb :sign_up
end

post '/users' do
  user = User.new(name: params[:name], email: params[:email])
  user.password = params[:password]
  user.save
  start_session(user)
  redirect '/'
end
