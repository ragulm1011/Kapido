require "test_helper"

class BookingRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get booking_requests_index_url
    assert_response :success
  end

  test "should get show" do
    get booking_requests_show_url
    assert_response :success
  end

  test "should get new" do
    get booking_requests_new_url
    assert_response :success
  end

  test "should get create" do
    get booking_requests_create_url
    assert_response :success
  end

  test "should get edit" do
    get booking_requests_edit_url
    assert_response :success
  end

  test "should get update" do
    get booking_requests_update_url
    assert_response :success
  end

  test "should get destroy" do
    get booking_requests_destroy_url
    assert_response :success
  end
end
