require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit games_url
  #
  #   assert_selector "h1", text: "Game"
  # end
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
    take_screenshot
  end

  test "in the grid?" do
    visit new_url
    fill_in 'word-input', with: "bar"
    click_on 'Submit'
    assert_text "The word is not in the grid."
    take_screenshot
  end

  test "english" do
    visit new_url
    fill_in 'word-input', with: "palavrao"
    click_on 'Submit'
    assert_text "oh no! it is not an english word, word not found"
    take_screenshot
  end
end
