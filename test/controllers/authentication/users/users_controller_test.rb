require "test_helper"
class Authentication::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:test)
  end

  test "should get new" do
    get new_user_url

    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: {
        user: {
          email: "test2@example.com",
          username: "test2",
          password: "123456"
        }
      }
    end

    assert_redirected_to tasks_url
    assert_equal flash[:notice], "Tu cuenta se ha creado!"
  end

  test "should logout" do
    login

    delete session_url(@user.id)

    assert_redirected_to tasks_url
    assert_equal flash[:notice], "Tu sesión ha terminado. Hasta la proxima!"
  end
end
