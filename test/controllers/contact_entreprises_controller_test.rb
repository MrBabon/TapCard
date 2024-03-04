require "test_helper"

class ContactEntreprisesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get contact_entreprises_new_url
    assert_response :success
  end

  test "should get create" do
    get contact_entreprises_create_url
    assert_response :success
  end

  test "should get show" do
    get contact_entreprises_show_url
    assert_response :success
  end

  test "should get edit" do
    get contact_entreprises_edit_url
    assert_response :success
  end

  test "should get update" do
    get contact_entreprises_update_url
    assert_response :success
  end

  test "should get destroy" do
    get contact_entreprises_destroy_url
    assert_response :success
  end
end
