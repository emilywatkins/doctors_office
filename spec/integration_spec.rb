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

describe('adding a new patient', {:type => :feature}) do
  it('allows a user to add a patient to be assigned to a dr later') do
    visit('/')
    click_link('Add New Patient')
    fill_in('name', :with =>'patient a')
    fill_in('dob', :with =>'2000-01-01 00:00:00')
    click_button('Add Patient')
    expect(page).to have_content('Success!')
  end
end
