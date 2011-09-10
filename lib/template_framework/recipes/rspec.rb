say("\nReplacing TestUnit with RSpec as your Testing Framework\n", Thor::Shell::Color::YELLOW )

gem "rspec-rails", "~> 2.6.1", :group => :test

remove_dir 'test'
gsub_file 'config/application.rb', 'require "rails/test_unit/railtie"', '# require "rails/test_unit/railtie"'

templater.post_bundler do
  generate 'rspec:install'

  spec_helper_path = 'spec/spec_helper.rb'

  gsub_file spec_helper_path, /\n\s+# Remove this line if you're not using ActiveRecord or ActiveRecord fixtures\n\s+config.fixture_path =.+$/, ''

  if templater.orm.mongoid?
    gsub_file spec_helper_path, /(config.use_transactional_fixtures = true)/, '# \1'
    inject_into_file spec_helper_path, templater.load_snippet('mongoid', 'rspec'), :after => "# config.use_transactional_fixtures = true\n"
  end
end

c = ask("\n\nWould you like to add Remarkable RSpec matchers? [Y|n]: ", Thor::Shell::Color::BLUE)
apply(templater.recipe('remarkable')) unless c == "n" || c == "no"

# Fixture Replacement
apply templater.recipe('factory_girl')