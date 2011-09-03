templater.post_bundler do
  # Instructions from http://kucaahbe.github.com/2011/08/30/html5-boilerplate-and-rails3.1.html

  say "\nFixing project for Rails 3.1+ with HTML5-boilerplate.\n", Thor::Shell::Color::YELLOW

  run "rm public/javascripts/jquery.js"
  run "rm public/javascripts/jquery.min.js"
  run "rm public/javascripts/rails.js"
  run "cp public/javascripts/* app/assets/javascripts/"
  run "rm public/javascripts/*"
  run "rm app/views/layouts/_javascripts.html.haml"
  create_file "app/views/layouts/_javascripts.html.haml", templater.load_template("_javascripts.html.haml", "html5_boilerplate")

  run "rm app/assets/javascripts/application.js"
  create_file "app/assets/javascripts/application.js", templater.load_template("application.js", "html5_boilerplate")

  run "mv app/stylesheets/* app/assets/stylesheets"
  run "rmdir app/stylesheets"
end