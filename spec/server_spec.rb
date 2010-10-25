# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Server do 
  before do
    @valid_details = {
      :name => 'app1',
      :size => 'c1.medium',
      :run_list => 'role[web_server]',
      :ami => 'ami-fae20893',
      :ssh_user => 'ubuntu'
    }
    @cluster = Cluster.new
  end
  
  context "given a valid dsl" do
    it "should correctly parse and populate the instance variables" do
      server = Server.new(@cluster)
      server.instance_eval( @valid_details.entries.collect {|e| "#{e[0]} '#{e[1]}'"}.join(";") )
      server.valid?.should == true
      server.name.should == 'app1'
      server.size.should == 'c1.medium'
      server.run_list.should == 'role[web_server]'
      server.ami.should == 'ami-fae20893'
      server.ssh_user.should == 'ubuntu'
    end
  end
  
  context "given a faulty dsl" do
    it "should not throw exceptions" do
      server = Server.new(@cluster)
      result = lambda { server.instance_eval("faulty") }
      result.should_not raise_error
    end
    
    it "should not throw exceptions" do
      server = Server.new(@cluster)
      server.should_receive(:puts).with("Unknown keyword 'faulty' used")
      server.instance_eval("faulty")
    end
    
    it "should not be valid" do
      server = Server.new(@cluster)
      server.instance_eval("faulty")
      server.should_not be_valid
    end
  end
  
  context "to be valid" do
    it "should require a name" do
      server = Server.new(@cluster)
      server.instance_eval(@valid_details.except(:name).entries.collect {|e| "#{e[0]} '#{e[1]}'"}.join(";"))
    end
    
    it "should require a size" do
      server = Server.new(@cluster)
      server.instance_eval(@valid_details.except(:size).entries.collect {|e| "#{e[0]} '#{e[1]}'"}.join(";"))
    end
    
    it "should require a run_list" do
      server = Server.new(@cluster)
      server.instance_eval(@valid_details.except(:run_list).entries.collect {|e| "#{e[0]} '#{e[1]}'"}.join(";"))
    end
    
    it "should require an ami" do
      server = Server.new(@cluster)
      server.instance_eval(@valid_details.except(:ami).entries.collect {|e| "#{e[0]} '#{e[1]}'"}.join(";"))
    end
    
    it "should require an ssh_user" do
      server = Server.new(@cluster)
      server.instance_eval(@valid_details.except(:ssh_user).entries.collect {|e| "#{e[0]} '#{e[1]}'"}.join(";"))
    end
    
    it "should need a valid dsl string" do
      server = Server.new(@cluster)
      server.instance_eval("name")
      server.should_not be_valid
    end
  end
  
end