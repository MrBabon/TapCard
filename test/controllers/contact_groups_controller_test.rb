require "test_helper"

class ContactGroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get contact_groups_show_url
    assert_response :success
  end
end
