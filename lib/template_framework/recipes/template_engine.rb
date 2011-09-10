say "\nWhich Template Engine would you like to use?\n", Thor::Shell::Color::BLUE

# Ask with highline
selection = templater.ui.choose 'Haml', 'Slim', 'ERB'
templater.template_engine.type = selection.underscore.to_sym

$stdout << "\n\n"

apply templater.recipe(templater.template_engine.type) unless templater.template_engine.type == :erb