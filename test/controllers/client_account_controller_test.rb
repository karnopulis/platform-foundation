require 'test_helper'

class ClientAccountControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get client_account_show_url
    assert_response :success
  end

end
