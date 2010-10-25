# -*- encoding: utf-8 -*-
class Cluster
  include DriedFunctions
  attr_reader :cluster_type, :region, :security_group, :security_key
  attr_reader :servers
  
  def initialize(cluster_type=:ec2)
    @cluster_type = cluster_type
    @servers = []
  end
  
  # Nice and simple for now, we want strings, GIEF!
  def valid?
    [:region, :security_group, :security_key].all? do |var|
      self.send(var).is_a? String
    end
  end
  
  
  def boot
    puts "Cluster reporting! Booting my servers..."
    threaded { :boot }
  end
  
  def terminate
    puts "Cluster reporting! Terminating my servers..."
    threaded { :terminate }
  end
  
  def delete
    puts "Cluster reporting! Deleting my servers..."
    threaded { :delete }
  end

  def server(size='c1.small', &block)
    server = Server.new(self)
    server.instance_eval(&block)
    @servers << server
  end
  
  def region(new_region=nil)
    set_or_read(new_region)
  end
  
  def security_group(new_security_group=nil)
    set_or_read(new_security_group)
  end
  
  def security_key(new_security_key=nil)
    set_or_read(new_security_key)
  end
  
  def domain(new_domain=nil)
    set_or_read(new_domain)
  end
  
  def env(new_env=nil)
    set_or_read(new_env)
  end
  
  def threaded(&block)
    threads = []
    @servers.each do |server|
      threads << Thread.new(server) do
        server.send(yield)
      end
    end
    threads.each {|thr| thr.join }
  end
  
  def method_missing(meth, *args, &blk)
    # warn only, we want all faulty dsl words to be ignored
    puts "Unknown keyword '#{meth.to_s}' used"
  end
end