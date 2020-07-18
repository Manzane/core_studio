Trestle.resource(:agendas) do
  menu do
    item :agendas, icon: "fa fa-calendar-alt", priority: 4, group: 'Planning'
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :lesson
    column :time
    column :capacity
    column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |agenda|
    select :lesson, Lesson.all
    datetime_field :time
    text_field :capacity
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:agenda).permit(:name, ...)
  # end
end
