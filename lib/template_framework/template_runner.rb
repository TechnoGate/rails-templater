$LOAD_PATH.unshift(File.expand_path('./../../', __FILE__))

require 'rails_templater'
require File.join(File.dirname(__FILE__), 'core_ext.rb')

# Removed javascript_framework - should be passed as parameter to "rails new"
# Removed sass - it is enabled by default in 3.1. Compass currently doesn't work
# without a couple of hacks. Should be fixed by the time 3.1 is released.
%w(default orm testing_framework code_coverage template_engine cucumber).each do |recipe|
  apply templater.recipe(recipe)
end

say("\nInitial generation complete\n", Thor::Shell::Color::YELLOW)

say("\nBeginning bundle install\n", Thor::Shell::Color::YELLOW)
run 'bundle install'
say("\nbundle install complete\n", Thor::Shell::Color::YELLOW)

execute_post_bundler_strategies

git :add => "."
git :commit => "-m 'Initial commit'"