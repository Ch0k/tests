class TestsMailer < ApplicationMailer
  def complited_test(user_test)
    @user = user_test.user
    @test = user_test.test

    mail to: @user.email
  end
end