class SignupMailer < ApplicationMailer
    default :from => 'mathilde@core-studio.fr'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Bienvenue sur Core Studio !' )
  end
end
