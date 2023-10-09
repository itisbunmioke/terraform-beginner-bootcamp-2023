# Terraform Beginner Bootcamp 2023 - Week 2

## Working with Ruby

### Bundler

Bundler is a package manager for Ruby. It is the primary way to isntall Ruby packages (known as gems) for Ruby.

#### Install Gems

You need to create a Gemfile and define your gems in that file

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you need to run the `bundle install` command.

This will install the gems on the system globally (unlike node.js which installs pcakages in place in a folder called node_modules)

A Gemfile.lock will be created to lock down the gem versioons used in this project.

#### Executing Ruby scripts in the context of bundler

We have to use `bundle exec` to tell future Ruby scripts to use teh gems we installed. This is the way we set context.

#### Sinatra

Sinatra is a micro web-framework for Ruby to build web apps.

It is great for mock or development servers or fro very simple projects.

You can create a web-sever in a single file.

https://sinatrarb.com/

## Terratowns Mock Server 

### Running the Web Server

We can run the web server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```

All of the code for our server is stored in the `server.rb` file.