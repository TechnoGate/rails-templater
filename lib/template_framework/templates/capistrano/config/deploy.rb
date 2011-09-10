# Adding necessary paths
$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.

#####################
## CHANGE AFTER ME ##
#####################

set :application,           "what-is-the-application-name"
set :repository,            "git://github.com/user/what-is-the-application-name.git"
set :scm,                   :git
set :git_enable_submodules, false

# Stages
# Stages can be really anything you want
set :stages, [:development, :staging, :production]
set :default_stage, :development

# Capistrano extensions
# Valid extensions: :multistage, :git, :deploy, :mysql, :rails, :contao, :contents, :god, :unicorn, :servers
set :capistrano_extensions, [:multistage, :git, :deploy, :mysql, :rails, :contents, :god, :servers]

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

##################
## DEPENDENCIES ##
##################

after "deploy", "deploy:cleanup" # keeps only last 5 releases

###########################
## DO NOT TOUCH AFTER ME ##
###########################

# Capistrano colors
require 'capistrano_colors'

# Require capistrano-exts
require 'capistrano-exts'

# rvm bootstrap
require "rvm/capistrano"