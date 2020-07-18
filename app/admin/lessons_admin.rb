Trestle.resource(:lessons) do
  menu do
    item :lessons, icon: "fa fa-heartbeat", priority: 3, group: 'Cours'
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :name
    column :category
    column :thematic
    column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |lesson|
    text_field :name
    select :category, Category.all
    select :thematic, Thematic.all
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:lesson).permit(:name, ...)
  # end
end
