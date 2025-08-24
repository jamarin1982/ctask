require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  setup do
    @user = User.last
  end
  test "welcome" do
    mail = UserMailer.with(user: @user).welcome
    assert_equal "Bienvenido a C-Task!", mail.subject
    assert_equal [ @user.email ], mail.to
    assert_equal [ "no_reply@c_task.com" ], mail.from
    assert_match "Hey #{@user.username}, bienvenido a C-Task!", mail.body.encoded
  end
end
