Given(/^I visit the login page$/) do
  visit ('/login')
  expect(page).to have_text('Login Page')
end

And(/^I have input (.*) as my username$/) do |username|
  page.fill_in('Username', :with=>username)
end

And(/^I have input (.*) as my password$/) do |password|
  page.fill_in('Password', :with=>password)
end

When(/^I click the login button$/) do
  page.click_button ('Login')
end

Then(/^I am logged into the secure area$/) do
  expect(page).to have_text('Secure Area'), 'Access Denied'
end

And(/^I input valid credentials%/) do
  page.fill_in('Username', :with=> TestConfig['valid_username'])
  page.fill_in('Password', :with=> TestConfig['valid_password'])
end