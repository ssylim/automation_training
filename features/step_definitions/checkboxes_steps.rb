checkbox_page = CheckboxPage.new

Given (/^I visit the checkboxes page$/) do
  visit('/checkboxes')
  expect(page).to have_text('Checkboxes')
end

When (/^I click on the checkbox (.*)$/) do |cb|
  checkbox_page.click_checkbox(cb)
end

Then (/^the checkbox (.*) is (.*)$/) do |cb, status|
  bool = status=='ticked'
  expect(checkbox_page.get_checkbox_status(cb)).to eq bool
end