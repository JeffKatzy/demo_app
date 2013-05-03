require 'spec_helper'

describe 'Teachers' do
  describe 'GET /' do
    visit root_path
    page.should have_button('Register')
  end
end