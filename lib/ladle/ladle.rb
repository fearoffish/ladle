# -*- encoding: utf-8 -*-
class Ladle
  attr_reader :cluster
    
  def self.run(filename)
    config = File.read(filename)
    ladle = Ladle.new
    return ladle.instance_eval(config)
  end
  
  def cluster(cluster_type=:ec2, &block)
    @cluster = Cluster.new(cluster_type)
    @cluster.instance_eval(&block)
    return @cluster
  end

end