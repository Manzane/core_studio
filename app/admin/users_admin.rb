Trestle.resource(:users) do
  # remove_action :destroy, :new, :update
  menu do
    item :users, icon: "fa fa-users", priority: 8
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :first_name
    column :last_name
    column :email
    column :created_at, align: :center
    actions
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
