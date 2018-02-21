require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new doctor', {:type => :feature}) do
  it('allows a user to click a doctor to see the specialty and patients') do
    visit('/')
    click_link('Add New Doctor')
    fill_in('name', :with =>'Dr. A')
    fill_in('specialty', :with =>'general')
    click_button('Add Doctor')
    expect(page).to have_content('Success!')
  end
end
