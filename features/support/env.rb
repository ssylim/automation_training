require 'rubygems'
require 'capybara'
require 'capybara/dsl'
require File.dirname(__FILE__) + '/testconfig'
require_relative 'testconfig'
require 'capybara/cucumber'
require 'selenium-webdriver'

Before do |scenario|
  Capybara.run_server = false
  Capybara.default_driver = TestConfig["capybara_default_driver"]
  Capybara.default_selector = :css
  Capybara.default_max_wait_time = TestConfig["default_timeout"]
  Capybara.app_host = TestConfig["default_site"]

  Capybara.register_driver :selenium do |app|
      caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => ["--start-maximized"]})
      @browser = Capybara::Selenium::Driver.new(app, {:browser => TestConfig["default_browser"], :desired_capabilities => caps})
  end
end

After do
  Capybara.current_session.driver.quit
end

#for parallel tests
Capybara.server_port = 8888 + ENV['TEST_ENV_NUMBER'].to_i

module Helpers
  def without_resynchronize
    page.driver.options[:resynchronize] = false
    yield
    page.driver.options[:resynchronize] = true
  end
end

World(Capybara::DSL, Helpers)

#this is executed at the end
at_exit do
  $test_case_id = nil
end
