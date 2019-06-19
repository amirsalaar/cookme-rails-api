class Api::V1::PaymentsController < Api::ApplicationController

  include Messenger

  def create
    order = Order.find params[:order_id]
    charge = Stripe::Charge.create(
      amount: (order.total * 100).to_i,
      currency: 'cad',
      source: stripe_params[:id],
      description: "Payment for order #{order.id} by #{current_user.full_name} collected."
    )
    order.update(transaction_id: charge.id)
    send_message(order, charge)
    render json: { status: 200 }, status: 200
  end

  private
  def stripe_params
    params.require(:stripeToken).permit!
  end
  
  def send_message(order_instance, charge_response)
    message = "\nThank you #{current_user.first_name} for ordering with CookMe.\nYour order was placed. Order ID: #{order_instance.id}; Total: $#{charge_response.amount / 100.0} was placed!"
    number = current_user.phone_number
    self.send_sms(number, message)
  end
end
