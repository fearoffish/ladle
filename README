Ladle
=====

Description
-----------

I wondered what the best way to start a cluster of EC2 machines with knife was, this is my experiment.  I've toyed with shell scripts, but I like the idea of describing in a Ruby DSL what to boot.  This is it, use Ladle to boot your instances.

It currently does nothing except has a skeleton for what it *will* do.

Usage
-----

    ladle test_cluster.rb

Run this command with a test_cluster.rb file that looks like:

    cluster do
      region 'us-east-1b'
      security_group 'app'
      security_key 'some_key'
      domain 'pharmmd.com'
      env 'nightly'

      server do
        name 'app1'
        size 'c1.medium'
        run_list 'role[web_server]'
        ami 'ami-fae20893'
        ssh_user 'ubuntu'
      end

      server do
        name 'app2'
        size 'c1.medium'
        run_list 'role[web_server]'
        ami 'ami-fae20893'
        ssh_user 'ubuntu'
      end

      server do
        name 'db1'
        size 'c1.medium'
        run_list 'role[db_server]'
        ami 'ami-fae20893'
        ssh_user 'ubuntu'
      end

      server do
        name 'workers'
        size 'c1.medium'
        run_list 'role[workers]'
        ami 'ami-fae20893'
        ssh_user 'ubuntu'
      end

      server do
        name 'mongo1'
        size 'm1.large'
        run_list 'role[mongo_master]'
        ami 'ami-fae20893'
        ssh_user 'ubuntu'
      end
    end