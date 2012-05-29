Ruby Quick Start Guide
======================

This guide will walk you through deploying a Ruby application on AWS using OpDemand.

Prerequisites
--------------
* A [free OpDemand account](https://app.opdemand.com/signup) with
  * Valid AWS credentials
  * Linked GitHub account
* The OpDemand Command Line Interface
* A Ruby application that is **hosted on GitHub**

Clone your Application
----------------------
The simplest way to get started is by forking OpDemand's sample application located at:
<https://github.com/opdemand/example-ruby-sinatra>

After forking the project, clone it to your local workstation using the SSH-style URL:

    $ git clone git@github.com:gabrtv/example-ruby-sinatra.git example-ruby-sinatra
    $ cd example-ruby-sinatra

If you want to use an existing application, no problem -- just make sure you've cloned it from GitHub.

Prepare your Application
------------------------
To use a Ruby application with OpDemand, you will need to conform to 3 basic requirements:

 * Use **Bundler** to manage dependencies
 * Use **Foreman** to manage processes
 * Use **Environment Variables** to manage configuration

If you're deploying the example application, it already conforms to these requirements.  If you're in a rush, skip to [Create a Platform](#create).

### Use Bundler to manage dependencies

On every deploy action, OpDemand will run a `bundle install --deployment` on all application workers to ensure dependencies are up to date and placed in `vendor/bundle`.

Manage your bundler dependencies by editing the `Gemfile` in the root of your application repository.  Here is an example Gemfile:

    . 'http://rubygems.org'
    gem 'sinatra'
    gem 'rack'

Use `bundle install` to install the required dependencies and generate a `Gemfile.lock` which will freeze dependency versions in preparation for deployment.

### Use Foreman to manage processes

OpDemand uses a Foreman Procfile to manage the processes that serve up your application.  The `Procfile` is how you define the command(s) used to run your application.  Here is an example `Procfile` that executes a ruby web server using `bundle exec` (highly recommended):

	web: bundle exec ruby web.rb -p $APPLICATION_PORT

This tells OpDemand to run one web process.  You can test this out locally by running setting the `APPLICATION_PORT` environment variable and calling `foreman start`.

    $ export APPLICATION_PORT=8080
	$ foreman start
    13:19:15 web.1     | started with pid 27022
    13:19:16 web.1     | [2012-05-10 13:19:16] INFO  WEBrick 1.3.1
    13:19:16 web.1     | [2012-05-10 13:19:16] INFO  ruby 1.9.3 (2012-04-20) [x86_64-darwin11.3.0]
    13:19:16 web.1     | [2012-05-10 13:19:16] INFO  WEBrick::HTTPServer#start: pid=27022 port=5000
    
### Use Environment Variables to manage configuration

OpDemand uses environment variables to manage your application's configuration.  For example, the application listener must use the value of the `APPLICATION_PORT` environment variable.  The following code snippets demonstrates how this can work inside your application:

	port = ENV["APPLICATION_PORT"] || 5000    # fallback to 5000

The same is true for external services like databases, caches and queues.  Here is an example in that shows how to connect to a MongoDB database using the `DATABASE_HOST` and `DATABASE_PORT` environment variables:
    
    database_host = ENV["DATABASE_HOST"] || "localhost"
    database_port = ENV["DATABASE_PORT"] || 27017
    connection = Mongo::Connection.new(database_host, database_port)

<h2 id="create">Create a new Platform </h2>

Use the `opdemand list` command to list the available infrastructure templates:

	$ opdemand list | grep ruby
    app/ruby/1node: Ruby Application (1-node)
    app/ruby/2node: Ruby Application (2-node with ELB)
    app/ruby/4node: Ruby Application (4-node with ELB)
    app/ruby/Nnode: Ruby Application (Auto Scaling)

Use the `opdemand create` command to create a new platform based on one of the templates listed.  To create an `appruby/1node` platform with `app` as its handle/nickname.

	$ opdemand create app --template=app/ruby/1node

Configure the Platform
----------------------
To quickly configure a platform from the command-line use `opdemand config [handle] --repository=detect`.  This will attempt to detect and install repository configuration including:

* Detecting your GitHub repository URL, project and username
* Generating and installing a secure SSH Deploy Key

More detailed configuration can be done using:

	$ opdemand config app					   # the entire config wizard (all sections)
	$ opdemand config app --section=provider   # only the "provider" section

Detailed configuration changes are best done via the web console, which exposes additional helpers, drop-downs and overrides.

Start the Platform
------------------
To start your platform use the `opdemand start` command:

	$ opdemand start app
	
You will see real-time streaming log output as OpDemand orchestrates the platform's infrastructure and triggers the necessary SSH deployments.  Once the platform has finished starting you can access its services using an `opdemand show`.

    $ opdemand show app

	Application URL (URL used to access this application)
	http://ec2-23-20-231-188.compute-1.amazonaws.com

Open the URL and you should see "Powered by OpDemand" in your browser.  To check on the status of your platforms, use the `opdemand status` command:

	$ opdemand status
	app: Ruby Application (1-node) (status: running)

Deploy the Platform
----------------------
As you make changes to your application code, push those to GitHub as you would normally.  When you're ready to deploy those changes, use the `opdemand deploy` command:

	$ opdemand deploy app

This will trigger an OpDemand deploy action which will -- among other things -- update configuration settings, pull down the latest source code, install new dependencies and restart services where necessary.


Additional Resources
====================
* <http://www.opdemand.com>

