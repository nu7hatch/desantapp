---
layout: default
---

## Quick start

There's a public Vagrant box configured to run with Desant. You can hop
into the project qucikly by running:

    $ gem install vagrant # if not installed yet
    $ vagrant up
    $ vagrant ssh
    vagrant@vagrant:~$ cd desant

Install all the dependencies using Bundler:

    vagrant@vagrant:~/desant$ bundle

Write down your environment configuration file (it contains admin credentials,
database configuration, etc):

    vagrant@vagrant:~/desant$ cp .env.sample .env

MySQL on attached Vagrant box comes with blank password for the `root` user.

Admin area uses very simple, single user authentication. Now generate
password hash for your password:

    vagrant@vagrant:~/$ rake password_hash PASS=yoursecretpass
    Your password hash: $2a$10...

Copy generated hash and assign it to `ADMIN_PASSWORD_HASH` in `.env`.

Last thing to do is to run create databases and run migrations: 

    vagrant@vagrant:~/$ foreman run rake db:create
    vagrant@vagrant:~/$ foreman run rake db:migrate

As you can se, from now on we must use Foreman to execute commands.
It's because all the stuff which is affected by the database requires 
its configuration to be loaded. Foreman automatically loads configuration 
from the `.env` file.

Now you should be able to start the application:

    vagrant@vagrant:~/$ foreman start

If everything went fine, you should go to `http://localhost:5000/` and see
a demo landing page! Use `http://localhost:5000/admin/` to access admin
area.

You can also populate some dummy data using `db:populate` rake task.

## Further reading

For more detailed information check project's [README file](https://github.com/nu7hatch/desantapp).
