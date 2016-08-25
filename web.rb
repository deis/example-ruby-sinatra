require 'sinatra'

set :port, ENV["PORT"] || 5000

get '/healthz' do
  status 200
end

get '/' do
  whom = ENV["POWERED_BY"] || "Deis"
  revision = ENV['WORKFLOW_RELEASE'] || "unknown"
  container = `hostname`.strip || "unknown"
  "Powered by #{whom}\nRelease #{revision} on #{container}\n"
end
