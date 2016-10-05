class UserMailer < ApplicationMailer
  default :from => 'hello@oz-expenses.com.au'

  def purchase_made(participant)
    @owed_amount = participant.amount
    @total_amount = participant.payment.amount
    @purchaser = participant.payer_name

    mail( 
      :to => participant.email,
      :subject => 'A purchase has been made'
    )
  end

  def settlement_made(payment)
    participant = payment.participants.first
    @paid_amount = -participant.amount
    @debtor = participant.payer_name
    mail( 
      :to => payment.email,
      :subject => "You've been paid!"
    )
  end

  def test_email
    mail( 
      :to => 'jarwelch@bellsouth.net',
      :subject => 'Thanks for signing up for our amazing app'
    )
  end
end
