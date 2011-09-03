# Code Coverage
if RUBY_VERSION >= "1.9"
  apply(templater.recipe('cover_me')) unless no?("\n\nWould you like to add CoverMe for code coverage? [Y|n]: ", Thor::Shell::Color::BLUE)
else
  if templater.testing_framework.rspec?
    apply(templater.recipe('rcov')) unless no?("\n\nWould you like to add RCov for code coverage? [Y|n]: ", Thor::Shell::Color::BLUE)
  end
end
