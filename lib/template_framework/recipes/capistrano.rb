if yes?("\n[Deployment] Would you like to use Capitrano for deployments? [y|n]: ", Thor::Shell::Color::BLUE)
  # Dependencies
  gem "capistrano", "~> 2.8.0", :group => :development

  # Configurations
  create_file "Capfile", templater.load_template("Capfile", "capistrano")

  def_app = `basename $(pwd)`.chomp
  application = ask("What's the name of the applicaiton [#{def_app}]?", Thor::Shell::Color::BLUE)
  application = def_app if application.blank?
  domain = ask("What domain [talkative.se]?", Thor::Shell::Color::BLUE)
  domain = "talkative.se" if domain.blank?
  def_repo = `cat .git/config | grep github | cut -d '=' -f2 | cut -c2-`.chomp
  repo = ask("Which repository [#{def_repo}]?", Thor::Shell::Color::BLUE)
  repo = def_repo if repo.blank?
  deploy_subdir = ask("Deploy subdir []?", Thor::Shell::Color::BLUE)
  deploy_to = ask("Deploy to (eg: /var/www/talkative.se)?", Thor::Shell::Color::BLUE)
  deploy_as = ask("Deploy as user [admin]?", Thor::Shell::Color::BLUE)
  deploy_as = "admin" if deploy_as.blank?

  file "config/deploy.rb", %Q{set :application, "#{application}"
set :domain, "#{domain}"
set :repository, "#{repo}"
set :deploy_subdir, "#{deploy_subdir}"
set :use_sudo, false
set :deploy_to, "#{deploy_to}"
set :deploy_via, :remote_cache
set :user, "#{deploy_as}"
set :scm, :git

role :web, domain
role :app, domain
role :db, domain, :primary => true

namespace :deploy do
  task :start, :roles => :app do
    run "touch \#{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing
  end

  desc "Restart application"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch \#{current_release}/tmp/restart.txt"
  end
end}

  if deploy_subdir.blank?
    run("cat config/deploy.rb | grep -v 'deploy_subdir' > /tmp/deploy.rb")
    remove_file("config/deploy.rb")
    copy_file("/tmp/deploy.rb", "config/deploy.rb")
  end
end