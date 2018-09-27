class BasePage
  include Capybara::DSL
  def click_element(element_type, element, element_description='')
    begin
      page.find(element_type.to_sym, element).click
    rescue
      fail 'Unable to click ' + element_description + ' ' + element_type + ' ' + element
    end

  end
end