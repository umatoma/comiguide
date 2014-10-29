class Users::Mailer < Devise::Mailer

  def confirmation_instructions(record, token, opts={})
    @token = token
    devise_mail(record, :confirmation_instructions, opts)
  end

  def reset_password_instructions(record, token, opts={})
    @token = token
    devise_mail(record, :reset_password_instructions, opts)
  end

  def unlock_instructions(record, token, opts={})
    @token = token
    devise_mail(record, :unlock_instructions, opts)
  end

  def reset_user_info(user, password)
    @user = user
    @password = password
    mail to: @user.email, subject: t('mailer.users.reset_user_info.subject')
  end
end
