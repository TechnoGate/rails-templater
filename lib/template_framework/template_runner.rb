$LOAD_PATH.unshift(File.expand_path('./../../', __FILE__))

require 'rails_templater'
require File.join(File.dirname(__FILE__), 'core_ext.rb')

# Removed sass - it is enabled by default in 3.1. Compass currently doesn't work
# Removed code_coverage - I'm getting errors with rails 3.1, investigate!
%w(default orm testing_framework mocking_framework template_engine cucumber devise capistrano).each do |recipe|
  apply templater.recipe(recipe)
end

say("\nInitial generation complete\n", Thor::Shell::Color::YELLOW)

say("\nBeginning bundle install\n", Thor::Shell::Color::YELLOW)
run 'bundle install'
say("\nbundle install complete\n", Thor::Shell::Color::YELLOW)

execute_post_bundler_strategies

git :add => '.'
git :commit => "-m 'Initial commit'"