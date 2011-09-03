templater.post_bundler do
  # Instructions from http://kucaahbe.github.com/2011/08/30/html5-boilerplate-and-rails3.1.html

  say "\nFixing project for Rails 3.1+ with HTML5-boilerplate.\n", Thor::Shell::Color::YELLOW

  copy_file "public/javascripts/modernizr.min.js", "app/assets/javascripts/"
  copy_file "public/javascripts/plugins.js", "app/assets/javascripts/"
  copy_file "public/javascripts/respond.min.js", "app/assets/javascripts/"
  remove_file "public/javascripts/modernizr.min.js"
  remove_file "public/javascripts/plugins.js"
  remove_file "public/javascripts/respond.min.js"

  remove_file "public/javascripts/jquery.js"
  remove_file "public/javascripts/jquery.min.js"
  remove_file "public/javascripts/rails.js" # used to provide UJS, but it is already provided by jquery-rails gem

  remove_file "app/views/layouts/_javascripts.html.haml"
  create_file "app/views/layouts/_javascripts.html.haml", templater.load_template("_javascripts.html.haml", "html5_boilerplate")

  remove_file "app/assets/javascripts/application.js"
  create_file "app/assets/javascripts/application.js", templater.load_template("application.js", "html5_boilerplate")

  directory "app/assets/stylesheets", "app/stylesheets"
  remove_dir "app/stylesheets"
end