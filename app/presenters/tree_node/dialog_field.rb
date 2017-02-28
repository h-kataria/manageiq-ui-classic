module TreeNode
  class DialogField < Node
    set_attribute(:title, &:label)
    set_attribute(:icon) { @object.decorate.fonticon }
  end
end
