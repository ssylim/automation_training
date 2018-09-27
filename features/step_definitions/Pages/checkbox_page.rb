class CheckboxPage < BasePage
  include Capybara::DSL

  def initialize
    @checkbox_xpath = '(//*[@type="checkbox"])[%s]'
  end

  def click_checkbox (cb)
    xpath = sprintf(@checkbox_xpath, cb.to_s)
    click_element('xpath', xpath)
  end

  def get_checkbox_status (cb)
    page.find(:xpath, sprintf(@checkbox_xpath, cb.to_s)).checked?
  end
end