

module RailsTemplater
  class NotSupportedError < Exception; end

  autoload :Cli, 'rails_templater/cli'
  autoload :FixtureReplacement, 'rails_templater/fixture_replacement'
  autoload :Orm, 'rails_templater/orm'
  autoload :Templater, 'rails_templater/templater'
  autoload :TemplateEngine, 'rails_templater/template_engine'
  autoload :TestingFramework, 'rails_templater/testing_framework'

  def self.template_runner
    File.join(File.dirname(__FILE__), 'template_framework', 'template_runner.rb')
  end

end
