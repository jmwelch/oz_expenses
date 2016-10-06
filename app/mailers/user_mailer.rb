class UserMailer < ApplicationMailer
  default :from => 'hello@oz-expenses.com.au'
  JARED_EMAIL = 'jarwelch@bellsouth.net'

  def purchase_made(participant)
    @owed_amount = participant.amount
    @total_amount = participant.payment.amount
    @purchaser = participant.payment_payer_name
    @item = participant.payment.name

    mail(
      :to => participant.email,
      :subject => 'A purchase has been made'
    )
  end

  def settlement_made(payment)
    participant = payment.participants.first
    @paid_amount = -participant.amount
    @debtor = participant.name
    mail(
      :to => payment.email,
      :subject => "You've been paid!"
    )
  end

  def deleted_payment(payment, participants)
    @payment = payment
    @participants = participants
    mail(
      :to => JARED_EMAIL,
      :subject => "Someone deleted a payment"
    )
  end

  def test_email
    mail(
      :to => JARED_EMAIL,
      :subject => 'Thanks for signing up for our amazing app'
    )
  end
end
