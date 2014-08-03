require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  test "should get play" do
    get :play
    assert_response :success
  end

  test "should get interval" do
    get :interval
    assert_response :success
  end

end
