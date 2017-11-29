ENV['RAILS_ENV'] = 'test'
require 'pry'
require 'rails'
require 'action_pack'
require 'action_dispatch'
require 'actionpack-cloudfront'
require 'rails/test_help'

ap_path = Gem::Specification.find_all_by_name('actionpack').first.full_gem_path
ap_test = File.join ap_path, 'test'
$LOAD_PATH.unshift(ap_test)
require 'abstract_unit'
