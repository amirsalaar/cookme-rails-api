class Api::V1::PaymentsController < Api::ApplicationController
  def create
    order = Order.find params[:order_id]
    charge = Stripe::Charge.create(
      amount: (order.total * 100).to_i,
      currency: 'cad',
      source: stripe_params[:id],
      description: "Payment for order #{order.id} by #{current_user.full_name} collected."
    )
    order.update(transaction_id: charge.id)
    render json: { status: 200 }, status: 200
  end

  private
  def stripe_params
    params.require(:stripeToken).permit!
  end
  
end
