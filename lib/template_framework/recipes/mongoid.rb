say("\nReplacing ActiveRecord with Mongoid\n", Thor::Shell::Color::YELLOW )

gem "mongoid", "~> 2.2.0"
gem "bson_ext", "~> 1.3.1"

inject_into_file 'config/environment.rb', :after => "require File.expand_path('../application', __FILE__)\n" do
  "require 'yaml'\n"
  "YAML::ENGINE.yamler= 'syck'\n"
end

templater.post_bundler do
  generate 'mongoid:config'
  run 'cp config/mongoid.yml config/mongoid.yml.example'
end
