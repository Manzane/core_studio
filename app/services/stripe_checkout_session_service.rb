class StripeCheckoutSessionService
    def call(event)
      order = Order.find_by(checkout_session_id: event.data.object.id)
      order.update(state: 'validée')
      credits_updater = CreditsUpdater.new(params, current_user)
      credits_updater.order
      raise
    end
  end