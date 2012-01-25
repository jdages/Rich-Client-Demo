require 'rubygems'
require 'sinatra'
require 'erb'
require 'json'
require 'couchrest'
require 'couchrest_model'

SERVER = CouchRest.new
DB     = SERVER.database!('users')

get '/test/:testVariable' do
  @lol = params[:testVariable]
  '<h1>' + User.all.size.to_s + '</h1>'
end


get '/CreateNewUser/' do
  erb :create
end

post '/CreateNewUser/' do
  user = User.new(:first_name=>params['first_name'],:last_name=>params['last_name'],:company_name=>params['company_name'], :job_title=>params['job_title'])
  user.save

  "<h1>User " + params[:first_name] + ' ' + params[:last_name] + " saved. There are now #{User.all.size.to_s}</h1>"
end

get '/Search/:firstName' do
   users = Array.new
  User.all.each do |user|
    if(user.first_name.include?(params[:firstName]))
      users.push(user)
      users.push(user)
     end
  end
   users = users.uniq
  output = '<ul>'
   users.each do |user|
     output += "<li>#{user.first_name.to_s}</li>"
   end

  output
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