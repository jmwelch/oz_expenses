class UserMailer < ApplicationMailer
  default :from => 'hello@oz-expenses.com.au'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def test_email
    mail( 
      :to => 'jarwe;ch@bellsouth.net',
      :subject => 'Thanks for signing up for our amazing app'
    )
  end
end
