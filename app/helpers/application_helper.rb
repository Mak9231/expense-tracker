module ApplicationHelper

  def bootstrap_class_for(flash_type)
    {
      success: "success",
      error: "danger",
      alert: "warning",
      notice: "info"
    }[flash_type.to_sym] || flash_type.to_s
  end

end


# TAILWIND

# def tailwind_color_for(flash_type)
#   case flash_type.to_sym
#   when :notice then "green"
#   when :alert  then "red"
#   when :error  then "red"
#   else "blue"
#   end
# end
