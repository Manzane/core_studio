Trestle.resource(:orders) do
  remove_action :destroy, :new, :update, :edit
  menu do
    item :orders, icon: "fa fa-shopping-cart", priority: 7, group: 'Commandes'
  end
  scopes do
    scope :pending, -> { Order.where(status: 0) }, label: 'Nouvelles commandes', default: true
    scope :paid, -> { Order.where(status: 1) }, label: 'Commandes payées'
    scope :cancelled, -> { Order.where(status: 2) }, label: 'Commandes annulées (non créditées)'
    scope :refunded, -> { Order.where(status: 3) }, label: 'Commandes annulées et décrédités'
    scope :total, -> { Order.all }, label: 'Toutes les commandes'
  end
  # Customize the table columns shown on the index view.
  #
  table do
    column :id
    column :user
    column :date
    column :amount
    column :state
    column :status
    column :created_at, align: :center
    actions
     actions do |toolbar, instance, admin|
      toolbar.link 'Valider', instance, action: :validate, method: :post, style: :primary, icon: "fas fa-credit-card", label: 'fds' if instance.waiting? && !instance.cancelled?
      toolbar.link 'Annuler', instance, action: :cancel, method: :post, style: :primary, icon: "fas fa-times", label: 'fds' if instance.waiting? 
      toolbar.link 'Décréditer', instance, action: :cancel_credits, method: :post, style: :primary, icon: "fab fa-creative-commons-nc-eu", label: 'fds' if instance.paid? 

    end
  end
  # Customize the form fields shown on the new/edit views.
  #
  # form do |order|
  #   text_field :name
  #
  #   row do
  #     col { datetime_field :updated_at }
  #     col { datetime_field :created_at }
  #   end
  # end

  controller do
    def validate
        @order = Order.find(params[:id])
        user = @order.user
        # raise
        @order.status = 1
        if @order.save
          packages = @order.cart.packages
          packages.each do |package|
            quantity = package.quantity
            category = package.category
            # binding.pry
            credits_updater = CreditsUpdater.new({"quantity" => quantity, "category" => category.id}, user)
            credits_updater.order
            # Credit.create(quantity: quantity, user: order.user, category: category)
          end
          flash[:message] = "Commande marquée comme payée"
          redirect_to orders_admin_index_path
        end
    end
    def cancel
      @order = Order.find(params[:id])
      # raise
      @order.status = 2
      if @order.save
        flash[:message] = "Commande marquée comme annulée"
        redirect_to orders_admin_index_path
      end
    end
    def cancel_credits
      @order = Order.find(params[:id])
      user = @order.user
      # raise
      @order.status = 3
      if @order.save
        packages = @order.cart.packages
        packages.each do |package|
          quantity = package.quantity
          category = package.category
          credits_updater = CreditsUpdater.new({"quantity" => quantity, "category" => category.id}, user)
          credits_updater.decrease
        end
        flash[:message] = "Commande marquée comme annulée et crédits enlevés"
        redirect_to orders_admin_index_path
      end
    end
  end
  routes do
    post :validate, on: :member
    post :cancel, on: :member
    post :cancel_credits, on: :member
  end
end
