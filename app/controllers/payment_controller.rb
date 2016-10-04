class PaymentController < ApplicationController
  def show
    @payments = Payment.all
  end
end
