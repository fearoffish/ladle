# -*- encoding: utf-8 -*-
class Server
  include DriedFunctions
  attr_reader :size, :run_list, :node_name, :ami, :ssh_user
  
  def initialize(cluster, &block)
    @cluster = cluster
  end
  
  # Nice and simple for now, we want strings, GIEF!
  def valid?
    [:size, :run_list, :node_name, :ami, :ssh_user].all? do |var|
      self.send(var).is_a? String
    end
  end
  
  # Could probably use the Chef::Knife class directly for this, have a look, hmm?
  def boot
    puts %x{ echo "knife ec2 server create '#{run_list}' -N #{node_name} -f #{size} -i #{ami} --region #{region} -G #{security_group} -x #{ssh_user} -S #{security_key}" }
  end
  
  def terminate
    puts "TERMINATING #{node_name}!"
  end
  
  def delete
    puts "DELETING #{node_name}"
  end
  
  def node_name
    "#{name}.#{env}.#{domain}"
  end
  
  def region
    @cluster.region
  end
  
  def security_group
    @cluster.security_group
  end
  
  def security_key
    @cluster.security_key
  end
  
  def env
    @cluster.env
  end
  
  def domain
    @cluster.domain
  end
  
  def run_list(new_run_list=nil)
    set_or_read(new_run_list)
  end
  
  def size(new_size=nil)
    set_or_read(new_size)
  end
  
  def name(new_name=nil)
    set_or_read(new_name)
  end
  
  def ami(new_ami=nil)
    set_or_read(new_ami)
  end
  
  def ssh_user(new_ssh_user=nil)
    set_or_read(new_ssh_user)
  end
  
  def method_missing(meth, *args, &blk)
    # warn only, we want all faulty dsl words to be ignored
    puts "Unknown keyword '#{meth.to_s}' used"
  end
end