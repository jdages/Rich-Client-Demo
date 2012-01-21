require 'rubygems'
require 'sinatra'
require 'erb'
require 'json'

get '/:something' do
  @lol = params['something']
  erb :index,
end

get '/data/' do
  {:john => 'first name', :dages => 'last name'}.to_json
end

get '/test/:testVariable' do
  @lol = params[:testVariable]
  '<h1>' + @lol + '</h1>'
end

get '/scripts/:scriptName' do

end
