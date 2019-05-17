class OrderMailer < ApplicationMailer

    default from: "no-reply@cookme.ca"

    def send_confirmation(order)
        order = order
        user = order.user
        mail to: user.email, subject: "CookMe - Order Confirmation"
    end
end
