c = ask("\n[Deployment] Would you like to use Capitrano for deployments? [Y|n]: ", Thor::Shell::Color::BLUE)
unless c == "n" || c == "no"
  # Dependencies
  gem "capistrano", "~> 2.8.0", :group => :development
  gem "capistrano-exts", "~>1.8", :group => :development

  templater.post_bundler do
    run "capify ."
    remove_file 'config/deploy.rb'
    create_file 'config/deploy.rb', templater.load_template('config/deploy.rb', 'capistrano')
    run "cap multistage:setup"
  end
end