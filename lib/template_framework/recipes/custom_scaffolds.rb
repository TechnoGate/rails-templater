# Copy all the customized scaffolding
create_file "lib/templates/rails/scaffold_controller/controller.rb", templater.load_template("controller.rb", "custom_scaffolds")