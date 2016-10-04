class PaymentController < ApplicationController
  def show
    @payment_hash = {}
    payer_ids = Payer.all.collect{|p| p.id}
    Payment.includes(:participants).all.each do |payment|
      @payment_hash.store(payment, Hash.new())
      payer_ids.each do |id|
        @payment_hash[payment].store(id, 0)
      end
      payment.participants.each do |part|
        @payment_hash[payment].store(part.payer_id, part.amount)
      end
    end
  end
end
