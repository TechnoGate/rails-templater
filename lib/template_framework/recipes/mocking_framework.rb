if templater.testing_framework.rspec?
  say "\nWhich mocking framework would you like to use?\n", Thor::Shell::Color::BLUE

  # Ask with highline
  selection = templater.ui.choose 'Mocha', 'Rspec'
  templater.mocking_framework.type = selection.underscore.to_sym

  $stdout << "\n\n"

  apply templater.recipe(templater.mocking_framework.type) unless templater.mocking_framework.type == :rspec
end