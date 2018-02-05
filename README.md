# README
# Pre-condition:
# ruby version: ruby 2.4.3p205
# rails version: Rails 5.2.0.rc1

#
# 
# 1 - ADD CAPISTRANO AND PUMA GEMS, 
#     Add these gems to your Gemfile:
#       gem "capistrano-rails", :group => :development
#       gem "capistrano3-puma"
#
#     then:
#     bundle install
#
# 2 - CAPIFY
#     bundle exec cap install STAGES=production
#     This Capistrano command prepares your Rails project for deployment by generating all the necessary Capistrano files:
#       Capfile (loads Capistrano plugins)
#       config/deploy.rb (configures the deployment recipes for your app)
#       config/deploy/production.rb (environment-specific server settings)
#
# 3 - LOAD THE RAILS AND PUMA PLUGINS FOR CAPISTRANO
#     At the bottom of Capfile, uncomment/add the following lines:
#       require "capistrano/bundler"
#       require "capistrano/rails/assets"
#       require "capistrano/rails/migrations"
#       require "capistrano/puma"
#
#     This tells Capistrano that we’d like to load the “recipes” for deploying a Rails app using bundler and Puma. 
#     That means we don’t have to write any code of our own! With a few config settings it will work out of the box.
#     You do not need the capistrano/rbenv plugin.
# 4 - CONFIGURE THE DEPLOY RECIPES
#     Set up config/deploy.rb (you can delete the rest of the sample deploy.rb that Capistrano generated):
#       set :application, "blog"
#       set :repo_url, "<your git@ bitbucket/github URL goes here>"
#       set :linked_dirs, %w(
#           bin log vendor/bundle public/system
#           tmp/pids tmp/cache tmp/sockets
#        )
#       set :puma_bind, "tcp://0.0.0.0:8080"
#     
#     Capistrano will deploy your app by fetching your app directly from the master branch of the git repository (e.g. Github or Bitbucket). 
#     The repo_url must be correct or Capistrano will fail early on in the deployment process. Make sure your latest code is pushed to origin/master!
#     Puma requires some tmp directories to be in place; the linked_dirs setting ensures these are set up.
#     Finally, puma_bind tells Puma to publish our app on TCP port 8080. 
#     Normally Puma connects to Nginx on a UNIX domain socket, but I’m skipping Nginx to keep this tutorial short. 
#     Instead, Puma will serve web requests directly on port 8080.
#
# 5 - TELL CAPISTRANO ABOUT YOUR VPS
#     In config/deploy/production.rb (again, you can delete the rest of the generated sample config):
#     server "<your VPS IP address goes here>",
#       :user => "deployer",
#       :roles => %w(web app db)
#
#     Here’s where we tell Capistrano how to SSH into the VPS, and what portions of the app are hosted there.
#     Since we only have one server, it necessarily is responsible for all roles: %w(web app db).
#
# 6 - SPECIFY THE RAILS SECRET KEY
#     In production, Rails expects a SECRET_KEY_BASE environment variable to be present. 
#     This key is used to encrypt cookies and keep your application safe from attackers.
#     We’ll make use of another rbenv plugin to set this environment variable. As the deployer user on your VPS, run:
#       echo "SECRET_KEY_BASE=34d69b7015b267fbd5efd91241c9ad1d7d08bd55f2b157558098426e0f4bb2e163a6899f90dc35ca58d5821ec16dac55bed151939eca80463111872499c86ae7" > ~/.rbenv/vars
#     The rbenv-vars plugin automatically loads the contents of the .rbenv/vars file into the environment whenever any Ruby process is executed.
#     This includes Rails, so SECRET_KEY_BASE will get passed via the environment to our app.
#
#     (In practice you should’t use my secret key; generate your own by running rails secret.)
#
# 7 - CREATE THE DEPLOYMENT DIRECTORY
#     As root on the VPS:
#       sudo mkdir -p /var/www/blog
#       sudo chown deployer /var/www/blog
#     Capistrano will deploy your app to /var/www/<application> by default, where the application name is defined by set :application in deploy.rb. 
#     Deployment will fail if this directory doesn’t exist or is not writable by the deployer user.
#
# 8 - COPY THE PUMA CONFIG TO THE VPS
#     Back on your local machine, run:
#       bundle exec cap production deploy:check
#       bundle exec cap production puma:config
#     The deploy:check command builds out the necessary directory structure. 
#     Then puma:config generates a puma.rb configuration file and places it in the correct location on the VPS.
#
# 9 - DEPLOY THE APP
#     Run:
#       bundle exec cap production deploy
#     
#     It may take a few minutes to complete the first deploy, due to the bundle install step, which needs to download all the necessary gems and compile native extensions.
#
#     But if all goes well, the app will soon be up an running on port 8080 of your VPS IP address. 
#     And don’t panic: a brand new Rails app with no customization will show this message:

#     The page you were looking for doesn’t exist.

#     That’s because you have a blank app with no routes, controllers, or views. Generate some, commit and push those to git, then run the deploy command again to see the results.

#    Congratulations!