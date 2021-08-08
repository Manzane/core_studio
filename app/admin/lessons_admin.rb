Trestle.resource(:lessons) do
  menu do
    item :lessons, icon: "fa fa-calendar-alt", priority: 3, group: 'Planning'
  end
  scopes do
    scope :past, -> { Lesson.past }, label: 'Passées', default: true
    scope :future, -> { Lesson.future }, label: 'Futurs'
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :name
    column :category
    column :thematic
    column :start_time
    column :duration
    column :capacity
    column :color
    column :created_at, align: :center
    column :updated_at, align: :center
    # actions
    actions do |toolbar, instance, admin|
      toolbar.link 'Créer une récurrence', instance, action: :occurrence, method: :post, style: :primary, icon: "fa fa-calendar-alt"
      toolbar.link 'Annuler cours et recréditer', instance, action: :cancel, method: :post, style: :danger, icon: "fas fa-sign-out-alt" if !instance.bookings.empty? 
    end
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |lesson|
    tab :lessons do
    text_field :name
    select :category_id, Category.published
    select :thematic_id, Thematic.published
    datetime_field :start_time
    text_field :duration
    text_field :capacity
    select :color, collection: %w(pink blue yellow white green)
    end
    tab :occurences do
    select :frequency_day, Lesson.frequency_days.keys
    datetime_field :end_date
    # :recurring do |key|
    # end
    end
    
  end

  controller do
    def occurrence
      @lesson = Lesson.find(params[:id])
      # raise
      @lesson.create_recurring_events(@lesson.frequency_day, @lesson.end_date, @lesson.start_time)
      flash[:message] = "Les occurrences sont en cours de génération"
      redirect_to lessons_admin_index_path
    end
    def cancel
      @lesson = Lesson.find(params[:id])
      category = Category.find(@lesson.category_id)
      bookings = @lesson.bookings
      @lesson.transaction do 
        Credit.transaction do
          bookings.each do |booking|
            user = booking.user
            credit = user.credits.find_by(category_id: category.id)
            credit.quantity += booking.quantity
            credit.save!
          end
        end
        @lesson.destroy!
        flash[:message] = "Les comptes on été recrédités"
        redirect_to lessons_admin_index_path
      end
    end
  end
  routes do
    post :occurrence, on: :member
    post :cancel, on: :member
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
