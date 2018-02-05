# README
#Pre-conditions
Ruby 2.4.3p205
Rails 5.2.0.rc1
Postgre account (or can update in /config/database.yml)
username: postgre
password: cuong12345

# 1 - Download source BackEnd from github.

# 2 - Create & Migrate DB
Open new terminal, change working directory to BackEnd folder and run command:
rails db:create
rails db:migrate
rake db:seed

Please don't turn off below terminal
# 3 - Run BackEnd API
Open new terminal, change working directory to BackEnd folder and run command:
rails server

# 4 - Run BackEnd cronjob
Open new terminal, change working directory to BackEnd folder and run command:
bundle exec crono RAILS_ENV=development
