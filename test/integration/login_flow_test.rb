require 'test_helper'

class LoginFlowTest < ActionDispatch::IntegrationTest
  test " the login page display for app" do
    get "/"
    assert_response :redirect
    follow_redirect!
    assert_match "Log in", response.body
  end
end
