Trestle.resource(:bookings) do
  remove_action :destroy, :new, :update
  menu do
    item :bookings, icon: "fa fa-calendar-check", priority: 5, group: 'Planning'
  end
  scope :future, -> { Booking.future }, label: 'Futurs', default: true
  scope :past, -> { Booking.past }, label: 'Passées'

  # Customize the table columns shown on the index view.
  #
  table do
    column :lesson
    column :user
    column :quantity
    column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |booking|
    select :lesson_id, Lesson.all
    select :user_id, User.all
    text_field :quantity
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:booking).permit(:name, ...)
  # end
end
