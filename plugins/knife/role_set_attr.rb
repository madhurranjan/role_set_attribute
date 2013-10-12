class RoleSetAttr < Chef::Knife
  deps do
    require 'chef'
  end
  banner "knife role_set_attr [default/override] [ENVIRONMENT] [ATTRIBUTE]('.' separated) [VALUE]"

  def attr_hash(attr_hierarchy,value)
    if attr_hierarchy.empty?
      return value
    end
    { attr_hierarchy.shift => attr_hash(attr_hierarchy,value) }
  end

  def run
    unless name_args.length == 4 and ["default","override"].include?(name_args.first)
      show_usage
      exit 1
    else
      attr_type = (@name_args[0] == "default") ? "default_attributes" : "override_attributes"
      role_name = @name_args[1]
      attr_name = @name_args[2]
      value = @name_args[3]
    end
    role = Chef::Role.load(role_name) || raise("Role #{role_name} does not exist")
    begin
      attr_hash = attr_hash(attr_name.split("."),value)
      eval("role.#{attr_type}(#{attr_hash})")
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
    end
    role.save
  end
end

