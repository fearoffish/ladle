cluster do
  region 'us-east-1b'
  security_group 'app'
  security_key 'SharePoint'
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
  
  server do
    name 'mongo2'
    size 'm1.large'
    run_list 'role[mongo_slave]'
    ami 'ami-fae20893'
    ssh_user 'ubuntu'
  end
end