![Desant](https://dl.dropbox.com/s/jfvo6fsyzgsdaad/head.png)

<blockquote>
<strong>Desant</strong> /dɛsɑːnt/ is a Polish word for military landing operations aimed 
at a bringing the landing force usually via landing craft to a shore or to 
land with the purpose of power projection ashore by forces coming usually 
from ships and also aircraft and able to fight.
</blockquote>

# Desant - Open source landing pages!

_Desant_ is an open source, neat landing page application. It's simple to
use, customize and extend to your needs. There's an awesome admin area
too - it will give you all the information and statistics you need.

## Quick start with Vagrant

There's a public Vagrant box configured to run with _Desant_. You can hop
into the project qucikly by running:

    $ gem install vagrant # if not installed yet
    $ vagrant up
    $ vagrant ssh
    vagrant@vagrant:~$ cd desant

Now just go and perform installation and setup steps described below.

## Installation and setup

First of all, install all the dependencies using _Bundler_:

    $ bundle

_Desant_ uses _MySQL_ as backend, so you should have this database installed 
and running. If you have it then copy `.env.sample` to `.env` - this file contains i.a. 
database configuration and admin setup:

    $ cp .env.sample .env

Admin area uses very simple, single user authentication. Now generate
password hash for your password:

    $ rake password_hash PASS=yoursecretpass
    Your password hash: $2a$10$9r64bxHKi3wxFwKDbjZYWOj4M26xp0RM0maoGeRo0JPy6Cg5OrzBC

Copy generated hash and assign it to `ADMIN_PASSWORD_HASH` in `.env` file,
edit database configuration and other settings.

Last thing to do is to run create databases and run migrations: 

    $ foreman run rake db:create
    $ foreman run rake db:migrate

As you can se, we must use `foreman run` command from now on - it's because
all the stuff which is affected by the database requires its configuration
to be loaded. _Foreman_ automatically loads configuration from the `.env`
file.

Now you should be able to start the application, we must use _Foreman_
here as well.

    $ foreman start

If everything wen fine, you should go to `http://localhost:5000/` and see
a demo landing page! Use `http://localhost:5000/admin/` to access admin
area.

To run RSpec unit tests use the following rake task:

    $ foreman run rake spec

Frontend tests (JavaScript unit tests) runs with:

    $ foreman run rake spec:jasmine

You can also run all the specs together:

    $ foreman run rake spec:all
    
For development purposes you can populate dummy data using following
rake task:

    $ foreman run rake db:populate

## Design introduction

_Desant_ is not a Rails app, it's an experiment with full stack, single
page application in _Backbone.js_ managed by _Sinatra_ backend. Here's
the directory structure explained:

    apps/                   applications (components actually).

    apps/*/assets/          asset pipeline files.
    apps/*/assets/static/   static files.
    apps/*/assets/app/      backbone application files.
    apps/*/assets/libs/     javascript libraries.
    apps/*/assets/styles/   stylesheet files.

    apps/*/forms/           form classes.
    apps/*/helpers/         application specified helpers. 
    apps/*/loggers/         custom notification subscribers.
    apps/*/models/          model classes.
    apps/*/presenters/      application presenters.
    apps/*/services/        application service classes.
    apps/*/spec/            application specified test files.  
    apps/*/views/           application view files.

    config/                 configuration files.
    db/migrate/             database migrations.
    lib/                    libraries and extensions, also app's core files.
    log/                    log files.
    spec/                   global test files.

Project is booted with `boot.rb` configuration file. All the apps (components)
are routed in config.ru, with standard Rack::Router.

The main goal of the experiment was to provide system for easy and robust
work on _Backbone.js_ application and reusable backend elements. It's also
aims to get rid of stupid Rails' assumptions that action = page, and models
are used both in forms and presentations. In _Desant_, **models** are separated
from **forms** and **presenters**. Model takes care about business logic, when
forms handle input and presenters output. More sophisticated operations
are handled with **services**. This design makes the stuff easy to test
and reuse across the projects.

### Coding conventions

TODO...

## Screenshots

![Registered users](https://dl.dropbox.com/s/ss5sbn8e4hh834i/5.png)

![Locations](https://dl.dropbox.com/s/q6frhrhnrnov8q5/3.png)

## Copyright

Copyright (C) 2012 by Chris Kowalik a.k.a nu7hatch <chris@nu7hat.ch>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
