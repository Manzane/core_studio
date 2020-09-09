class StripeCheckoutSessionService
    def call(event)
      order = Order.find_by(checkout_session_id: event.data.object.id)
      order.update!(state: "validée")
      # binding.pry
      if order.save
        packages = order.cart.packages
        packages.each do |package|
          quantity = package.quantity
          category = package.category
          user = order.user
          # binding.pry
          credits_updater = CreditsUpdater.new({"quantity" => quantity, "category" => category.id}, user)
          credits_updater.order
          # Credit.create(quantity: quantity, user: order.user, category: category)
        end
      end
    end
  end