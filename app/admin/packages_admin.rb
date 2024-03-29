Trestle.resource(:packages) do
  # remove_action :destroy
  menu do
    item :packages, icon: "fa fa-star", priority: 6, group: 'Commandes'
  end 
  active_storage_fields do
    [:image]
  end
  scopes do
    scope :pushlished, -> { Package.published }, label: 'Publiés', default: true
    scope :draft, -> { Package.unpublished }, label: 'Dépubliés'
    scope :total, -> { Package.all }, label: 'Tous'
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :category
    column :quantity
    column :price
    column :published
    column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |package|
    select :category_id, Category.published
    check_box :published
    number_field :quantity
    number_field :price_cents
    active_storage_field :image
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:package).permit(:name, ...)
  # end
end
