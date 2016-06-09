# Ruby Quick Start Guide

This guide will walk you through deploying a Ruby application on [Deis Workflow][].

## Usage

```console
$ git clone https://github.com/deis/example-ruby-sinatra.git
$ cd example-ruby-sinatra
$ deis create
Creating Application... done, created zeroed-larkspur
Git remote deis added
remote available at ssh://git@deis-builder.deis.rocks:2222/zeroed-larkspur.git
$ git push deis master
Counting objects: 119, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (59/59), done.
Writing objects: 100% (119/119), 25.15 KiB | 0 bytes/s, done.
Total 119 (delta 52), reused 119 (delta 52)
Starting build... but first, coffee!
-----> Ruby app detected
-----> Compiling Ruby/Rack
-----> Using Ruby version: ruby-2.0.0
-----> Installing dependencies using bundler 1.11.2
       Running: bundle install --without development:test --path vendor/bundle --binstubs vendor/bundle/bin -j4 --deployment
       Fetching gem metadata from http://rubygems.org/..........
       Fetching version metadata from http://rubygems.org/..
       Rubygems 2.0.14.1 is not threadsafe, so your gems will be installed one at a time. Upgrade to Rubygems 2.1.0 or higher to enable parallel gem installation.
       Installing rack 1.6.1
       Installing tilt 2.0.1
       Using bundler 1.11.2
       Installing rack-protection 1.5.3
       Installing sinatra 1.4.6
       Bundle complete! 1 Gemfile dependency, 5 gems now installed.
       Gems in the groups development and test were not installed.
       Bundled gems are installed into ./vendor/bundle.
       Bundle completed (4.33s)
       Cleaning up the bundler cache.

-----> Discovering process types
       Procfile declares types -> web
       Default process types for Ruby -> rake, console, web
-----> Compiled slug size is 16M
Build complete.
Launching App...
Done, zeroed-larkspur:v2 deployed to Deis

Use 'deis open' to view this application in your browser

To learn more, use 'deis help' or visit https://deis.com/

To ssh://git@deis-builder.deis.rocks:2222/zeroed-larkspur.git
 * [new branch]      master -> master
$ curl http://zeroed-larkspur.deis.rocks
Powered by Deis
Running on container ID zeroed-larkspur-v2-web-tzfyp
```

## Additional Resources

* [GitHub Project](https://github.com/deis/workflow)
* [Documentation](https://deis.com/docs/workflow/)
* [Blog](https://deis.com/blog/)

[Deis Workflow]: https://github.com/deis/workflow#readme
