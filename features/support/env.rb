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

  caps_arr = []
  caps_arr[0] = '--start-maximized'
  if TestConfig['headless']
    caps_arr[1] = '--headless'
  end

  caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => caps_arr})

  Capybara.register_driver :selenium do |app|

      @browser = Capybara::Selenium::Driver.new(app, {:browser => TestConfig["default_browser"], :desired_capabilities => caps})
  end
end

After do
  Capybara.current_session.driver.quit
end

After do |scenario|
  if scenario.failed?
    dir_path = 'features/screenshots/'
    if Dir.exist?(dir_path)
      Dir.foreach(dir_path) do |f|
        file = File.join(dir_path, f)
        #File.delete(file) if f != '.' && f != '..'
      end
      p "=========Directory exists at #{dir_path}"
    else
      Dir.mkdir(dir_path, 0777)
      p "=========Directory is created at #{dir_path}"
    end
    time = Time.now.strftime('%d_%m_%YT%H_%M_%S_')
    name_of_scenario = time + "#{scenario.name}"
    p "Name of snapshot is #{name_of_scenario}"
    file_path = File.expand_path(dir_path)+'/'+name_of_scenario +'.png'
    page.driver.browser.save_screenshot file_path
    p 'Snapshot is taken'
    p '#===========================================================#'
    p "Scenario: #{scenario.name}"
  end
end
