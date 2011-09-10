gsub_file 'Gemfile', /^gem 'sqlite3'.*$/, ''

gsub_file 'config/application.rb', 'require "active_record/railtie"', '# require "active_record/railtie"'
gsub_file 'config/initializers/wrap_parameters.rb',
  /# Disable root element in JSON by default.\nActiveSupport.on_load(:active_record) do\nself.include_root_in_json = false\nend/,
  ''

remove_file 'config/database.yml'