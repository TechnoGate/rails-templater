say "\nWhich Testing Framework would you like to use?\n", Thor::Shell::Color::BLUE

# Ask with highline
selection = templater.ui.choose 'rspec', 'TestUnit'
templater.testing_framework.type = selection.underscore.to_sym

$stdout << "\n\n"

apply templater.recipe(templater.testing_framework.type)