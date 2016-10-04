class PaymentsController < ApplicationController
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

  def new
    @payment = Payment.new
  end

  def create
    payment = Payment.new(payment_params)
    if payment.save
      flash[:success] = "Created!"
      redirect_to root_path and return
    else
      flash[:error] = payment.errors.full_messages.to_sentence
      redirect_to new_payment_path and return
    end
  end

  private

  def payment_params
    params.require(:payment).permit!
  end
end
