# Remove old Gemfile
remove_file "Gemfile"

# Replace with cleaned version
create_file "Gemfile", templater.load_template("Gemfile", "gem")