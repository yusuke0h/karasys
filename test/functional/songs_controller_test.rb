require 'test_helper'

class SongsControllerTest < ActionController::TestCase
  test "should get entry" do
    get :entry
    assert_response :success
  end

end
