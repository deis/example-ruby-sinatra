require 'sinatra'

set :port, ENV["PORT"] || 5000

get '/' do
  whom = ENV["POWERED_BY"] || "Deis!"
  "Powered by " + whom + "\n"
end
