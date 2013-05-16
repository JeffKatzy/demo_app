require 'spec_helper'

describe 'Lessons' do
  describe 'GET lessons/new' do
    it 'displays a link to add lecture' do
      visit new_lesson_path
      page.should have_link('Add a lecture')
    end

    it 'displays the lecture form on click', :js => true do
      visit new_lesson_path
      page.should_not have_text('Lecture name')
      click_link('Add a lecture')
      page.should have_text('Lecture name')
    end

    it 'displays the question form on click', :js => true do
      visit new_lesson_path
      click_link('Add a lecture')
      page.should_not have_text('Question name')
      click_link('Add a question')
      page.should have_text('Question name')
    end

    # it "removes the lecture form upon click" do
    #   visit new_lesson_path
    #   click_link('Add a lecture')
    #   page.should have_text('Lecture name')
    # end

    # it "removes the question form upon click" do
    #   visit new_lesson_path
    #   click_link('Add a lecture')
    #   click_link('Add a question')
    #   page.should have_text('Question name')
    # end
  end
end