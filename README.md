# Ruby Quick Start Guide

This guide will walk you through deploying a Ruby application on Deis.

## Prerequisites

* A [User Account](http://docs.deis.io/en/latest/client/register/) on a [Deis Controller](http://docs.deis.io/en/latest/terms/controller/).
* A [Deis Formation](http://docs.deis.io/en/latest/gettingstarted/concepts/#formations) that is ready to host applications

If you do not yet have a controller or a Deis formation, please review the [Deis installation](http://docs.deis.io/en/latest/gettingstarted/installation/) instructions.

## Setup your workstation

* Install [Ruby](http://www.ruby-lang.org/en/downloads/) if you haven't already (we recommend Ruby 1.9.3)
* Install [RubyGems](http://rubygems.org/pages/download) to get the `gem` command on your workstation
* Install [Foreman](http://ddollar.github.com/foreman/) with `gem install foreman`

## Clone your Application

If you want to use an existing application, no problem.  You can also use the Deis sample application located at <https://github.com/opdemand/example-ruby-sinatra>.  Clone the example application to your local workstation:

	$ git clone https://github.com/opdemand/example-ruby-sinatra.git
	$ cd example-ruby-sinatra

## Prepare your Application

To use a Ruby application with Deis, you will need to conform to 3 basic requirements:

 1. Use [Bundler](http://bundler.io/) to manage dependencies
 2. Use [Foreman](http://ddollar.github.com/foreman/) to manage processes
 3. Use [Environment Variables](https://help.ubuntu.com/community/EnvironmentVariables) to manage configuration inside your application

If you're deploying the example application, it already conforms to these requirements.

#### 1. Use Bundler to manage dependencies

Bundler requires that you explicitly declare your dependencies using a [Gemfile](http://bundler.io/v1.3/gemfile.html).  Here is a very basic example:

	source 'http://rubygems.org'
	ruby '1.9.3'
	gem 'sinatra'
	gem 'rack'

Install your dependencies on your local workstation using `bundle install`:

	$ bundle install
	Fetching gem metadata from http://rubygems.org/..........
	Fetching gem metadata from http://rubygems.org/..
	Using rack (1.5.2) 
	Installing rack-protection (1.5.0) 
	Installing tilt (1.3.6) 
	Installing sinatra (1.4.2) 
	Using bundler (1.3.5) 
	Your bundle is complete!
	Use `bundle show [gemname]` to see where a bundled gem is installed.


#### 2. Use Foreman to manage processes

Deis relies on a [Foreman](http://ddollar.github.com/foreman/) `Procfile` that lives in the root of your repository.  This is where you define the command(s) used to run your application.  Here is an example `Procfile`:`

    web: bundle exec ruby web.rb -p $PORT

This tells Deis to run `web` workers using the command `ruby web.rb -p $PORT` wrapped in a `bundle exec` (highly recommended). You can test this locally by running `foreman start`.

    $ foreman start
    10:06:14 web.1  | started with pid 63945
    10:06:15 web.1  | [2013-04-06 10:06:15] INFO  WEBrick 1.3.1
    10:06:15 web.1  | [2013-04-06 10:06:15] INFO  ruby 1.9.3 (2012-02-16) [x86_64-darwin12.3.0]
    10:06:15 web.1  | == Sinatra/1.4.2 has taken the stage on 5000 for development with backup from WEBrick
    10:06:15 web.1  | [2013-04-06 10:06:15] INFO  WEBrick::HTTPServer#start: pid=63945 port=5000

You should now be able to access your application locally at <http://localhost:5000>.

#### 3. Use Environment Variables to manage configuration

OpDemand uses environment variables to manage your application's configuration.  For example, your application listener must use the value of the `PORT` environment variable.  The following code snippet demonstrates how this can work inside your application:

    require 'sinatra'
    set :port, ENV["PORT"] || 5000

## Create a new Application

Per the prerequisites, we assume you have access to an existing Deis formation. If not, please review the Deis [installation instuctions](http://docs.deis.io/en/latest/gettingstarted/installation/).

Use the following command to create an application on an existing Deis formation.

	$ deis create --formation=<formationName> --id=<appName>
	Creating application... done, created <appName>
	Git remote deis added    
	
If an ID is not provided, one will be auto-generated for you.

## Deploy your Application

Use `git push deis master` to deploy your application.

	$ git push deis master
	Counting objects: 75, done.
	Delta compression using up to 4 threads.
	Compressing objects: 100% (40/40), done.
	Writing objects: 100% (75/75), 15.10 KiB, done.
	Total 75 (delta 30), reused 75 (delta 30)
	       Ruby/Rack app detected
	-----> Using Ruby version: ruby-1.9.3

Once your application has been deployed, use `deis open` to view it in a browser. To find out more info about your application, use `deis info`.

## Scale your Application

To scale your application's [Docker](http://docker.io) containers, use `deis scale` and specify the number of containers for each process type defined in your application's `Procfile`. For example, `deis scale web=8`.

	$ deis scale web=8
	Scaling containers... but first, coffee!
	done in 15s
	
	=== <appName> Containers
	
	--- web: `bundle exec ruby web.rb -p $PORT`
	web.1 up 2013-10-25T20:24:14.414Z (rubyFormation-runtime-1)
	web.2 up 2013-10-25T20:24:51.691Z (rubyFormation-runtime-1)
	web.3 up 2013-10-25T20:24:51.705Z (rubyFormation-runtime-1)
	web.4 up 2013-10-25T20:24:51.719Z (rubyFormation-runtime-1)
	web.5 up 2013-10-25T20:24:51.734Z (rubyFormation-runtime-1)
	web.6 up 2013-10-25T20:24:51.750Z (rubyFormation-runtime-1)
	web.7 up 2013-10-25T20:24:51.768Z (rubyFormation-runtime-1)
	web.8 up 2013-10-25T20:24:51.788Z (rubyFormation-runtime-1)

## Configure your Application

Deis applications are configured using environment variables. The example application includes a special `POWERED_BY` variable to help demonstrate how you would provide application-level configuration. 

	$ curl -s http://yourapp.yourformation.com
	Powered by Deis
	$ deis config:set POWERED_BY=Ruby
	=== <appName>
	POWERED_BY: Ruby
	$ curl -s http://yourapp.yourformation.com
	Powered by Ruby

`deis config:set` is also how you connect your application to backing services like databases, queues and caches. You can use `deis run` to execute one-off commands against your application for things like database administration, initial application setup and inspecting your container environment.

	$ deis run ls -la
	total 68
	drwxr-xr-x  6 root root 4096 Oct 25 20:24 .
	drwxr-xr-x 57 root root 4096 Oct 25 20:27 ..
	drwxr-xr-x  2 root root 4096 Oct 25 20:23 .bundle
	-rw-r--r--  1 root root    5 Oct 25 20:23 .gitignore
	drwxr-xr-x  2 root root 4096 Oct 25 20:24 .profile.d
	-rw-r--r--  1 root root  135 Oct 25 20:24 .release
	-rw-r--r--  1 root root   11 Oct 25 20:23 .ruby-version
	-rw-r--r--  1 root root   67 Oct 25 20:23 Gemfile
	-rw-r--r--  1 root root  277 Oct 25 20:23 Gemfile.lock
	-rw-r--r--  1 root root  553 Oct 25 20:23 LICENSE
	-rw-r--r--  1 root root   37 Oct 25 20:23 Procfile
	-rw-r--r--  1 root root 9165 Oct 25 20:23 README.md
	drwxr-xr-x  2 root root 4096 Oct 25 20:23 bin
	drwxr-xr-x  5 root root 4096 Oct 25 20:23 vendor
	-rw-r--r--  1 root root  127 Oct 25 20:23 web.rb

## Troubleshoot your Application

To view your application's log output, including any errors or stack traces, use `deis logs`.

    $ deis logs
    <show output>

## Additional Resources

* [Get Deis](http://deis.io/get-deis/)
* [GitHub Project](https://github.com/opdemand/deis)
* [Documentation](http://docs.deis.io/)
* [Blog](http://deis.io/blog/)
 