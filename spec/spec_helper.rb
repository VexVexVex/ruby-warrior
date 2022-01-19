# frozen_string_literal: true

require 'rubygems'
require 'rspec'
require 'rspec/collection_matchers'
require File.dirname(__FILE__) + '/../lib/ruby_warrior'

RSpec.configure do |config|
  config.mock_with :mocha
  config.raise_errors_for_deprecations!
  config.before(:each) do
    RubyWarrior::Config.reset
  end
end
