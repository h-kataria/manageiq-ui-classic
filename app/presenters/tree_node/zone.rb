module TreeNode
  class Zone < Node
    set_attribute(:icon) { @object.decorate.fonticon }
    set_attributes(:title, :tooltip) do
      if @options[:is_current]
        tooltip = "#{ui_lookup(:model => @object.class.to_s)}: #{@object.description} (#{_('current')})"
        title   = ViewHelper.content_tag(:strong, ERB::Util.html_escape(tooltip))
      else
        title   = "#{ui_lookup(:model => @object.class.to_s)}: #{@object.description}"
        tooltip = title
      end
      [title, tooltip]
    end
  end
end
