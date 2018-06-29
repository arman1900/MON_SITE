require 'test_helper'

class CompanyControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get company_create_url
    assert_response :success
  end

  test "should get destroy" do
    get company_destroy_url
    assert_response :success
  end

  test "should get edit" do
    get company_edit_url
    assert_response :success
  end

end
