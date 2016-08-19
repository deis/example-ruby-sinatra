# Ruby Quick Start Guide

This guide will walk you through deploying a Ruby application on [Deis Workflow][].

## Usage

```console
$ git clone https://github.com/deis/example-ruby-sinatra.git
$ cd example-ruby-sinatra
$ deis create
Creating Application... done, created benign-quilting
Git remote deis successfully created for app benign-quilting.
$ git push deis master
Delta compression using up to 4 threads.
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 1.12 KiB | 0 bytes/s, done.
Total 4 (delta 2), reused 0 (delta 0)
Starting build... but first, coffee!
-----> Ruby app detected
-----> Compiling Ruby/Rack
-----> Using Ruby version: ruby-2.3.1
-----> Installing dependencies using bundler 1.11.2
       Running: bundle install --without development:test --path vendor/bundle --binstubs vendor/bundle/bin -j4 --deployment
       Fetching gem metadata from http://rubygems.org/..........
       Fetching version metadata from http://rubygems.org/..
       Installing tilt 2.0.5
       Installing puma 3.6.0 with native extensions
       Installing rack 1.6.4
       Using bundler 1.11.2
       Installing rack-protection 1.5.3
       Installing sinatra 1.4.7
       Bundle complete! 2 Gemfile dependencies, 6 gems now installed.
       Gems in the groups development and test were not installed.
       Bundled gems are installed into ./vendor/bundle.
       Bundle completed (4.87s)
       Cleaning up the bundler cache.
-----> Writing config/database.yml to read from DATABASE_URL

-----> Discovering process types
       Procfile declares types -> web
       Default process types for Ruby -> rake, console, web
-----> Compiled slug size is 19M
Build complete.
Launching App...
Done, benign-quilting:v2 deployed to Workflow

Use 'deis open' to view this application in your browser

To learn more, use 'deis help' or visit https://deis.com/

To ssh://git@deis-builder.deis.rocks:2222/benign-quilting.git
 * [new branch]      master -> master
$ curl http://benign-quilting.deis.rocks
Powered by Deis
Running on container ID benign-quilting-web-1803317222-dlfom
```

## Additional Resources

* [GitHub Project](https://github.com/deis/workflow)
* [Documentation](https://deis.com/docs/workflow/)
* [Blog](https://deis.com/blog/)

[Deis Workflow]: https://github.com/deis/workflow#readme
