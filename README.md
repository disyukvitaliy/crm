# Awesome CRM

Awesome CRM is my test project. I do it for learning purpose.

### Done
  - The knowledge about structure, working flow, base functionality and capabilities of RoR framework
  - Understanding ruby and metaprogramming
  - Using various gems for extension base functionality
  - Extensive refactoring with using concerns, services, helpers, gems, partials and views inheritance
  - Working with relations, migrations, seeds and resource-based routing
  - Database design (PostgreSQL)
  - Using devise for authorisation
  - Smart role-permissions system based on pundit gem
  - Writing readable and understandable code
  - Documenting code with YARD
  - Testing code with RSpec, Capybara
  - Writing views with Haml
  - Using Bootstrap Superhero Theme
  - Working with Git, branches, merges
  - Work on the Ubuntu operating system
  
### To do
  - Upgrade tests. Make them smarter
  - REST API for retrieving data from system. Make gem for this
  - Use Redis
  - Use Elasticsearch
  - Something else to improve skills

### Installation is pretty simple

```sh
$ git clone https://github.com/disyukvitaliy/crm.git
$ bundle
$ rake db:create db:migrate db:seed
$ rails s
```

Note database.yml is under .gitignore file. Make sure you have added it before launch.