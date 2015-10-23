# Ruby Quick Start Guide

This guide will walk you through deploying a Ruby application on Deis.

## Usage

```console
$ git clone https://github.com/deis/example-ruby-sinatra.git
$ cd example-ruby-sinatra
$ deis create
$ git push deis master
Counting objects: 117, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (66/66), done.
Writing objects: 100% (117/117), 23.71 KiB | 0 bytes/s, done.
Total 117 (delta 51), reused 99 (delta 43)
-----> Ruby app detected
-----> Compiling Ruby/Rack
-----> Using Ruby version: ruby-2.0.0
-----> Installing dependencies using 1.7.12
       Running: bundle install --without development:test --path vendor/bundle --binstubs vendor/bundle/bin -j4 --deployment
       Fetching gem metadata from http://rubygems.org/..........
       Using bundler 1.7.12
       Installing tilt 2.0.1
       Installing rack 1.6.1
       Installing rack-protection 1.5.3
       Installing sinatra 1.4.6
       Your bundle is complete!
       Gems in the groups development and test were not installed.
       It was installed into ./vendor/bundle
       Bundle completed (4.49s)
       Cleaning up the bundler cache.

-----> Discovering process types
       Procfile declares types -> web
       Default process types for Ruby -> rake, console, web
-----> Compiled slug size is 16M

-----> Building Docker image
remote: Sending build context to Docker daemon 16.67 MB
remote: build context to Docker daemon
Step 0 : FROM deis/slugrunner
 ---> 385e8129fbdf
Step 1 : RUN mkdir -p /app
 ---> Running in 197b84e685df
 ---> 877ce2869c1c
Removing intermediate container 197b84e685df
Step 2 : WORKDIR /app
 ---> Running in d01eb9481986
 ---> 40b847b64730
Removing intermediate container d01eb9481986
Step 3 : ENTRYPOINT /runner/init
 ---> Running in 791a0331c54e
 ---> fe7cf39f55ff
Removing intermediate container 791a0331c54e
Step 4 : ADD slug.tgz /app
 ---> 16614c6abbe6
Removing intermediate container 882592a87784
Step 5 : ENV GIT_SHA f1aaf798dc8a66d9bcf38dffacdce3f3fdb8f41d
 ---> Running in c0a8f8f8da51
 ---> 049f8c3e23da
Removing intermediate container c0a8f8f8da51
Successfully built 049f8c3e23da
-----> Pushing image to private registry

-----> Launching...
       done, dogged-nautilus:v2 deployed to Deis

       http://dogged-nautilus.local3.deisapp.com

       To learn more, use `deis help` or visit http://deis.io

To ssh://git@deis.local3.deisapp.com:2222/dogged-nautilus.git
 * [new branch]      master -> master
$ curl http://dogged-nautilus.local3.deisapp.com
Powered by Deis
Running on container ID 27877b89e278
$ deis config:set POWERED_BY="Engine Yard"
Creating config... done, v3

=== dogged-nautilus
DEIS_APP: dogged-nautilus
POWERED_BY: Engine Yard
$ curl http://dogged-nautilus.local3.deisapp.com
Powered by Engine Yard
Running on container ID 8a9fc2a79248
```

## Additional Resources

* [Get Deis](http://deis.io/get-deis/)
* [GitHub Project](https://github.com/deis/deis)
* [Documentation](http://docs.deis.io/)
* [Blog](http://deis.io/blog/)
