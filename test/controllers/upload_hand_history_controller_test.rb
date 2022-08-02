require "test_helper"

class UploadHandHistoryControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get upload_hand_history_new_url
    assert_response :success
  end

  test "should get create" do
    get upload_hand_history_create_url
    assert_response :success
  end
end
