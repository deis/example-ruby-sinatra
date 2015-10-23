require 'sinatra'

set :port, ENV["PORT"] || 5000

get '/' do
  whom = ENV["POWERED_BY"] || "Deis"
  container = `hostname`.strip || "unknown"
  "Powered by " + whom + "\nRunning on container ID " + container + "\n"
end
