if yes?("\nWould you like to use Compass? [y|n]: ", Thor::Shell::Color::BLUE)
  design_options = {
    'Option' => 'Design Framework',
    '1' => 'Compass with HTML5-boilerplate',
    '2' => 'Compass',
    '3' => 'Compass with blueprint semantic',
    '4' => 'Compass with blueprint basic',
    '5' => 'Compass with 960.gs'
  }

  print_table design_options.to_a, :ident => 4
  design_selection = ask("\nOption: ", Thor::Shell::Color::BLUE)

  design_framework = case design_selection
    when "1"
      :compass_html5
    when "2"
      :compass
    when "3"
      :compass_blueprint_semantic
    when "4"
      :compass_blueprint
    when "5"
      :compass_960
    else
      :none
  end

  unless design_framework == :none
    gem "compass", "~> 0.12.alpha.0", :group => :assets

    framework_option = case design_framework
      when :compass_html5
        gem "html5-boilerplate", :group => :assets
        "-r html5-boilerplate -u html5-boilerplate"
      when :compass_blueprint
        "--using blueprint/basic"
      when :compass_blueprint_semantic
        "--using blueprint/semantic"
      when :compass_960
        gem 'compass-960-plugin', :group => :assets
        "-r ninesixty --using 960"
    end

    compass_command = "bundle exec compass init rails . #{framework_option}"

=begin move
mv public/javascripts/modernizr.min.js app/assets/javascripts
mv public/javascripts/plugins.js app/assets/javascripts
mv public/javascripts/respond.min.js app/assets/javascripts
=end

=begin remove
rm public/javascripts/jquery.js
rm public/javascripts/jquery.min.js
rm public/javascripts/rails.js # used to provide UJS, but it is already provided by jquery-rails gem
=end

# Instructions from http://kucaahbe.github.com/2011/08/30/html5-boilerplate-and-rails3.1.html

    templater.post_bundler do
      run compass_command
    end

    if design_framework == :compass_html5

    end

  end
end
