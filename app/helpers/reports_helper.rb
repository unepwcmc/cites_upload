module ReportsHelper
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", :class => "btn remove danger")
  end

  def link_to_add_fields(name, f, association, file_type)
    new_object = f.object.class.reflect_on_association(association).klass.new(:file_type => file_type)
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render("uploaded_files/uploaded_file_fields", :f => builder)
    end
    "#{link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')", :class => "btn add_file")}<p class='clear' />".html_safe
  end
end
