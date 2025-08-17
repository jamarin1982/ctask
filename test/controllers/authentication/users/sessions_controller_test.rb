require "test_helper"
class Authentication::SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:test)
  end
  test "should get new" do
    get new_session_url

    assert_response :success
  end

  test "should login an user by email" do
    post sessions_url, params: {
      login: @user.email,
      password: "123456"
    }

    assert_redirected_to home_url
  end

  test "should login an user by username" do
    post sessions_url, params: {
      login: @user.username,
      password: "123456"
    }

    assert_redirected_to home_url
  end
end
