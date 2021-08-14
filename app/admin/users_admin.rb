Trestle.resource(:users) do
  # remove_action :destroy, :new, :update
  menu do
    item :users, icon: "fa fa-users", priority: 8
  end

  scopes do
    scope :total, -> { User.where.not(last_sign_in_at: nil) }, label: 'Total Comptes actifs', default: true
    scope :active, -> { User.where.not(invitation_accepted_at: nil) }, label: 'Invitation acceptée'
    scope :pending, -> { User.where(invitation_accepted_at: nil, last_sign_in_at: nil) }, label: 'Invitation en attente'
    scope :created, -> { User.where.not(last_sign_in_at: nil).where(invitation_accepted_at: nil) }, label: 'Compte créé'
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :first_name
    column :last_name
    column :email
    column :created_at, sort: { default_order: :desc }
    column :last_sign_in_at
    column :invitation_sent_at
    actions
     actions do |toolbar, instance, admin|
      toolbar.link 'Réenvoyer une invitation', instance, action: :reinvite, method: :post, style: :primary, icon: "fa fa-paper-plane", label: 'fds' if instance.pending? && !instance.signed_in?
    end
  end

  # Customize the form fields shown on the new/edit views.
  #

  form do |user|
    text_field :email
    text_field :first_name
    text_field :last_name
    # table user.credits, admin: :credits do 
    #   column :category
    #   column :quantity
    # end
    # fields_for :credits do |credit|
    fields_for :credits, user.credits || user.build_credits do 
      # Form helper methods now dispatch to the product.category form scope
      # text_field :category 
      row do
        col(sm: 4) { select :category_id, Category.all.map { |c| [c.name, c.id] }, readonly: true }
        col(sm: 8) { text_field :quantity }
      end
      # select :category_id, Category.all.map { |c| [c.name, c.id] }, readonly: true
      # text_field :quantity
    end
  end
  
  controller do
    def create    
      user = User.new(params[:user])
      user.valid?
      user.errors.messages.except!(:password) #remove password from errors
      # binding.pry
      if (user.errors.any?)
        flash.now[:error] = flash_message("create.failure", title: "Warning!", message: "Please correct the errors below.")
        render "new", status: :unprocessable_entity
      else
        if User.invite!(resource_params)
          flash[:message] = "Une invitation a été envoyée à #{params[:user][:email]}"
          redirect_to users_admin_index_path(scope: 'pending')
        else
          flash.now[:error] = flash_message("create.failure", title: "Warning!", message: "Please correct the errors below.")
          render "new", status: :unprocessable_entity
        end
      end
    end

    def reinvite
      user = User.find(params[:id])
      user.invite!
      flash[:message] = "Une nouvelle invitation a été envoyée à #{user.email}"
      redirect_to users_admin_index_path(scope: 'pending')
    end
  end

  routes do
    post :reinvite, on: :member
  end


  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:user).permit(:name, ...)
  # end
end
