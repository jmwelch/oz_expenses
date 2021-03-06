class PaymentsController < ApplicationController
  def totals
    payers = Payer.all
    payer_ids = payers.collect{|p| p.id}
    @totals_hash = {}

    payers.each do |payer|
      @totals_hash.store(payer, {})
      payers.each do |payee|
        @totals_hash[payer].store(payee, 0) unless payee == payer
      end
    end
    Participant.includes(:payer, payment: :payer).each do |participant|
      if @totals_hash[participant.payer][participant.payment.payer] != 0
        old_amount = @totals_hash[participant.payer][participant.payment.payer]
        if participant.amount > @totals_hash[participant.payer][participant.payment.payer]
          @totals_hash[participant.payer][participant.payment.payer] = 0
          @totals_hash[participant.payment.payer][participant.payer] = participant.amount - old_amount
        else
          @totals_hash[participant.payer][participant.payment.payer] = old_amount - participant.amount
        end
      else
        @totals_hash[participant.payment.payer][participant.payer] += participant.amount
      end
    end

    @totals_hash.values.each do |hash|
      hash.delete_if{|k,v| v == 0}
    end
    @totals_hash.delete_if{|k,v| v.empty?}
  end

  def index
    @payment_hash = {}
    payers = Payer.all
    payer_ids = payers.collect{|p| p.id}
    Payment.includes(:participants).order('created_at desc').each do |payment|
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
    @payment_type = params[:payment_type]
    @payment.participants.build
  end

  def create
    payment = Payment.new(payment_params)
    if payment.settlement?
      participant = payment.participants.first
      participant.amount = -payment.amount
    end
    if payment.save
      if payment.purchase?
        payment.participants.each do |participant|
          UserMailer.purchase_made(participant).deliver_now 
        end
      elsif payment.settlement?
        UserMailer.settlement_made(payment).deliver_now
      end
      flash[:success] = "Created!"
      redirect_to root_path and return
    else
      flash[:error] = payment.errors.full_messages.to_sentence
      redirect_to new_payment_path and return
    end
  end

  def destroy
    payment = Payment.find(params[:id])
    participants = payment.participants
    if payment.destroy
      UserMailer.deleted_payment(payment, participants).deliver_now
      flash[:success] = "Deleted!"
    else
      flash[:error] = payment.errors.full_messages.to_sentence
    end
    redirect_to root_path and return
  end

  private

  def payment_params
    params.require(:payment).permit!
  end
end
