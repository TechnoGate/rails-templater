# Dependencies
gem "jammit", "~> 0.6.0"
gem "yui-compressor", "~> 0.9.6"
gem "closure-compiler", "~> 1.1.1"

create_file "config/assets.yml", templater.load_template("assets.yml", "jammit")
create_file "config/initializers/syck_yaml.rb", templater.load_template("syck_yaml.rb", "jammit")