# Code Coverage
if RUBY_VERSION >= "1.9"
  c = ask("\n\nWould you like to add CoverMe for code coverage? [Y|n]: ", Thor::Shell::Color::BLUE)
  apply(templater.recipe('cover_me')) unless c == "n" || c == "no"
else
  if templater.testing_framework.rspec?
    c = ask("\n\nWould you like to add RCov for code coverage? [Y|n]: ", Thor::Shell::Color::BLUE)
    apply(templater.recipe('rcov')) unless c == "n" || c == "no"
  end
end
