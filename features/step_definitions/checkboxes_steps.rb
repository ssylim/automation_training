Given (/^I visit the checkboxes page$/) do
  visit('/checkboxes')
  expect(page).to have_text('Checkboxes')
end

When (/^I click on the checkbox (.*)$/) do |cb|
  page.find(:xpath, "(//*[@type=\"checkbox\"])[#{cb}]").click
end

Then (/^the checkbox (.*) is (.*)$/) do |cb, status|
  bool = status=='ticked'
  expect(page.find(:xpath, "(//*[@type=\"checkbox\"])[#{cb}]").checked?).to eq bool
end