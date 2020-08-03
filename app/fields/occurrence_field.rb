class OccurrenceField < Trestle::Form::Field
    def field
      content_tag :div, class: 'input-group' do
        safe_join [
          content_tag(:div, builder.object.send(name), class: 'input-group-addon'),
          builder.raw_select(name, ['monday','tuesday', 'wednesday', 'thursday', 'firday', 'saturday', 'sunday'], {}, {class: 'form-control', style: '-webkit-appearance:none;'}),
          builder.raw_number_field(name.to_sym, {class: 'form-control'}),
          builder.raw_number_field(name.to_sym, {class: 'form-control'}),
          builder.raw_datetime_field(name.to_sym, {class: 'form-control', style: '-webkit-appearance:none;'}),
          builder.raw_datetime_field(name.to_sym, {class: 'form-control', style: '-webkit-appearance:none;'})      

        # ]
        ]

      end
    end
  end