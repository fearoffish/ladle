# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Cluster do 
  before do
    @valid_details = {
      :region => 'us-east-1b',
      :security_group => 'app',
      :security_key => 'MyKey'
    }
  end
  
  context "given a valid dsl" do
    it "should correctly parse and populate the instance variables" do
      cluster = Cluster.new
      cluster.instance_eval( @valid_details.entries.collect {|e| "#{e[0]} '#{e[1]}'"}.join(";") )
      cluster.valid?.should == true
      cluster.region.should == 'us-east-1b'
      cluster.security_group.should == 'app'
      cluster.security_key.should == 'MyKey'
    end
  end
  
  context "given a faulty dsl" do
    it "should not throw exceptions" do
      cluster = Cluster.new(@cluster)
      result = lambda { cluster.instance_eval("faulty") }
      result.should_not raise_error
    end
    
    it "should not throw exceptions" do
      cluster = Cluster.new(@cluster)
      cluster.should_receive(:puts).with("Unknown keyword 'faulty' used")
      cluster.instance_eval("faulty")
    end

    
    it "should not be valid" do
      cluster = Cluster.new
      cluster.instance_eval("faulty")
      cluster.should_not be_valid
    end
  end
  
  context "to be valid" do
    it "should require a region" do
      cluster = Cluster.new(@cluster)
      cluster.instance_eval(@valid_details.except(:region).entries.collect {|e| "#{e[0]} '#{e[1]}'"}.join(";"))
    end
    
    it "should require a security_group" do
      cluster = Cluster.new(@cluster)
      cluster.instance_eval(@valid_details.except(:security_group).entries.collect {|e| "#{e[0]} '#{e[1]}'"}.join(";"))
    end
    
    it "should require a security_key" do
      cluster = Cluster.new(@cluster)
      cluster.instance_eval(@valid_details.except(:security_key).entries.collect {|e| "#{e[0]} '#{e[1]}'"}.join(";"))
    end
  end
  
end