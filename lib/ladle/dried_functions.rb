# -*- encoding: utf-8 -*-
module DriedFunctions
  def set_or_read(value=nil)
    method_caller = caller.first.scan(/`(.*)'/)[0]
    case value
    when nil
      instance_variable_get("@#{method_caller}")
    else
      instance_variable_set("@#{method_caller}", value)
    end
  end
end