say "\nWhich ORM/ODM would you like to use?\n", Thor::Shell::Color::BLUE

# Ask with highline
selection = templater.ui.choose 'ActiveRecord', 'Mongoid'
templater.orm.type = selection.underscore.to_sym

$stdout << "\n\n"

apply templater.recipe(templater.orm.type) unless templater.orm.type == :active_record