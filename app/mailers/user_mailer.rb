class UserMailer < ApplicationMailer
  default :from => 'hello@oz-expenses.com.au'

  def test_email
    mail( 
      :to => 'jarwelch@bellsouth.net',
      :subject => 'Thanks for signing up for our amazing app'
    )
  end
end
