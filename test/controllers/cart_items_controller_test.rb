require 'test_helper'

class CartItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cart_items_index_url
    assert_response :success
  end

  test "should get create" do
    get cart_items_create_url
    assert_response :success
  end

  test "should get delete" do
    get cart_items_delete_url
    assert_response :success
  end

end
