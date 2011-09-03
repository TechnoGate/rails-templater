if templater.orm.mongoid?
  gem "remarkable_activemodel", ">=4.0.0.alpha4", :group => :test
  gem "remarkable_mongoid", "~> 0.6.0", :group => :test
  require_remarkable = "\nrequire 'remarkable/active_model'\nrequire 'remarkable/mongoid'"
elsif templater.orm.active_record?
  gem 'remarkable_activerecord', '>=4.0.0.alpha4', :group => :test
  require_remarkable = "\nrequire 'remarkable/active_record'"
end

templater.post_bundler do
  inject_into_file 'spec/spec_helper.rb', require_remarkable, :after => "require 'rspec/rails'"
end
