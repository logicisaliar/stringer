require 'test_helper'

class PhrasesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get phrases_new_url
    assert_response :success
  end

  test "should get show" do
    get phrases_show_url
    assert_response :success
  end

end
