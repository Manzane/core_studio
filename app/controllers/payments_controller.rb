class PaymentsController < ApplicationController
    def new
        @order = current_user.orders.where(state: 'en cours').find(params[:order_id])
      end
end
