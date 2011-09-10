say("\nReplacing RSpec with Mocha as your Mocking Framework\n", Thor::Shell::Color::YELLOW )

gem 'mocha', :group => :test

templater.post_bundler do
  # Edit spec_helper.rb
  spec_helper_path = 'spec/spec_helper.rb'

  gsub_file spec_helper_path, /(# )?(config.mock_with :rspec)/, '# \2'
  gsub_file spec_helper_path, /(# )?(config.mock_with :mocha)/, '\2'
end