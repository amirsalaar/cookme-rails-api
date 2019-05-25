class Api::V1::PaymentsController < Api::ApplicationController
  def create
    order = Order.find params[:order_id]
    charge = Stripe::Charge.create(
      amount: (order.total * 100).to_i,
      currency: 'cad',
      source: params[:stripe_token],
      description: "Charge for order #{order.id} by #{current_user.full_name}"
    )
    order.update! (transaction_id: charge.id)
    render json: { status: 200 }, status: 200
  rescue => error
    render json: { errors: error.full_messages.join(', ') }
  end
end
