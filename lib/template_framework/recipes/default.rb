# Delete all unnecessary files
remove_file "README"
remove_file "public/index.html"
remove_file "public/robots.txt"
remove_file "public/images/rails.png"

# Create project files
create_file "README.markdown"
create_file "log/.gitkeep"
create_file "tmp/.gitkeep"

apply templater.recipe("git")
gem "rails3-generators", "~> 0.17.4", :group => :development