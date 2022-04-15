class UserMailer < ApplicationMailer
  def account_activation user
    @user = user

    mail to: user.email, subject: t("global.mailer.subject_active")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("global.mailer.subject_password_reset")
  end
end
