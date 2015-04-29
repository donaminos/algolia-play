require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test "should get indexData" do
    get :indexData
    assert_response :success
  end

  test "should get searchData" do
    get :searchData
    assert_response :success
  end

end
