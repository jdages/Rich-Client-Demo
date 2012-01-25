require 'rubygems'
require 'sinatra'
require 'erb'
require 'json'
require 'couchrest'
require 'couchrest_model'

SERVER = CouchRest.new
DB     = SERVER.database!('users')

get '/:something' do
  @lol = params['something']
  erb :index
end

get '/data/' do
  "Lol"
end

get '/test/:testVariable' do
  @lol = params[:testVariable]
  '<h1>' + User.all.size.to_s + '</h1>'
end

get '/scripts/:scriptName' do

end

get '/CreateNewUser/' do
  erb :create
end

post '/CreateNewUser/:userInfo' do


end

class User < CouchRest::Model::Base
  use_database DB

  property :first_name
  property :last_name, :alias => :family_name
  property :company_name
  property :job_title
  timestamps!

  view_by :first_name

end