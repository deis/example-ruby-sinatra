# Ruby Quick Start Guide

This guide will walk you through deploying a Ruby application on Deis.

## Usage

    $ deis create
    Creating application... done, created rental-mainsail
    Git remote deis added
    $ git push deis master
    Counting objects: 95, done.
    Delta compression using up to 8 threads.
    Compressing objects: 100% (49/49), done.
    Writing objects: 100% (95/95), 20.25 KiB | 0 bytes/s, done.
    Total 95 (delta 41), reused 91 (delta 40)
    -----> Ruby app detected
    -----> Compiling Ruby/Rack
    -----> Using Ruby version: ruby-1.9.3
    -----> Installing dependencies using 1.5.2
           Running: bundle install --without development:test --path vendor/bundle --binstubs vendor/bundle/bin -j4 --deployment
           Fetching gem metadata from http://rubygems.org/..........
           Fetching additional metadata from http://rubygems.org/..
           Using bundler (1.5.2)
           Installing tilt (1.3.6)
           Installing rack (1.5.2)
           Installing rack-protection (1.5.0)
           Installing sinatra (1.4.2)
           Your bundle is complete!
           Gems in the groups development and test were not installed.
           It was installed into ./vendor/bundle
           Bundle completed (6.99s)
           Cleaning up the bundler cache.
    -----> Discovering process types
           Procfile declares types -> web
           Default process types for Ruby -> rake, console, web
    -----> Compiled slug size is 12M
    -----> Building Docker image
    Uploading context 11.81 MB
    Uploading context
    Step 0 : FROM deis/slugrunner
     ---> 5567a808891d
    Step 1 : RUN mkdir -p /app
     ---> Running in 51ed76a5c4fb
     ---> 928145890a08
    Removing intermediate container 51ed76a5c4fb
    Step 2 : ADD slug.tgz /app
     ---> 900668707b5d
    Removing intermediate container 02006a3e27b9
    Step 3 : ENTRYPOINT ["/runner/init"]
     ---> Running in 7135a1e3096d
     ---> 8f9abc66fa14
    Removing intermediate container 7135a1e3096d
    Successfully built 8f9abc66fa14
    -----> Pushing image to private registry

           Launching... done, v2

    -----> rental-mainsail deployed to Deis
           http://rental-mainsail.local.deisapp.com

           To learn more, use `deis help` or visit http://deis.io

    $ curl -s http://rental-mainsail.local.deisapp.com
    Powered by Deis!

## Additional Resources

* [Get Deis](http://deis.io/get-deis/)
* [GitHub Project](https://github.com/deis/deis)
* [Documentation](http://docs.deis.io/)
* [Blog](http://deis.io/blog/)
