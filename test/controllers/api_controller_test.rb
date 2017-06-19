require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_index_url
    assert_response :success
  end

  test "should get show" do
    get api_show_url
    assert_response :success
  end

  test "should get create" do
    get api_create_url
    assert_response :success
  end

  test "should get update" do
    get api_update_url
    assert_response :success
  end

  test "should get delete" do
    get api_delete_url
    assert_response :success
  end

  test "should get create_bulk" do
    get api_create_bulk_url
    assert_response :success
  end

  test "should get update_bulk" do
    get api_update_bulk_url
    assert_response :success
  end

  test "should get delete_bulk" do
    get api_delete_bulk_url
    assert_response :success
  end

end
