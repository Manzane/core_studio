Trestle.resource(:thematics) do
  remove_action :destroy
  menu do
    item :thematics, icon: "fa fa-spa", priority: 2, group: 'Cours'
  end
  scopes do
    scope :pushlished, -> { Thematic.published }, label: 'Publiés', default: true
    scope :draft, -> { Thematic.unpublished }, label: 'Dépubliés'
    scope :total, -> { Thematic.all }, label: 'Tous'
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :name
    column :published
    column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |thematic|
    text_field :name
    check_box :published
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:thematic).permit(:name, ...)
  # end
end
