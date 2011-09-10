if yes?("\n[User authentication] Would you like to add flexible user authentication with Devise? [y|n]: ", Thor::Shell::Color::BLUE)

  gem 'devise'

  model_name = ask('Name of Devise model? [user]: ', Thor::Shell::Color::BLUE)
  model_name = 'user' if model_name.blank?

  generate_views = yes?('Generate Devise views? [y|n]: ', Thor::Shell::Color::BLUE)

  templater.post_bundler do
    generate "devise:install"
    generate "devise #{model_name}"
    generate "devise:views" if generate_views

    inject_into_file 'config/environments/development.rb',
      "\n  config.action_mailer.default_url_options = { :host => 'localhost:3000' }\n",
      :after => "  config.action_mailer.raise_delivery_errors = false\n"

    inject_into_file "app/models/#{model_name.downcase}.rb",
      "  attr_accessible :email, :password, :password_confirmation\n",
      :before => 'end'

    if templater.testing_framework.rspec?
      inject_into_file 'spec/spec_helper.rb',
        "  config.include Devise::TestHelpers, :type => :controller\n",
        :after => "# config.use_transactional_fixtures = true\n"
    end
  end

  if yes?("\n[User authentication] Would like to add a username field and allow the user to login with either an email or a username? [y|n]: ", Thor::Shell::Color::BLUE)
    templater.post_bundler do
      generate "migration add_username_to_users username:string"
      generate "devise:views" unless generate_views

      model_addons = <<-EOS

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login
      EOS

      if templater.orm.active_record?
        model_addons << <<-EOS

  protected

    def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    end
        EOS
      elsif templater.orm.mongoid?
        model_addons << <<-EOS

  field :email

  protected

    def self.find_for_database_authentication(conditions)
      login = conditions.delete(:login)
      self.any_of({ :username => login }, { :email => login }).first
    end
        EOS
      end

      # Add required options in the model
      gsub_file 'app/models/user.rb', /^end$/, model_addons + "\nend"

      gsub_file 'app/views/devise/sessions/new.html.erb', /:email/, ':login'

      ['new', 'edit'].each do |f|
        inject_into_file "app/views/devise/registrations/#{f}.html.erb",
          "\n\n  <div><%= f.label :username %><br />\n  <%= f.text_field :username %></div>",
          :after => '<%= devise_error_messages! %>'
      end

    end
  end
end
