# -*- encoding: utf-8 -*-
begin
  require 'ladle/dried_functions'
  require 'ladle/ladle'
  require 'ladle/cluster'
  require 'ladle/server'
rescue LoadError => x
  puts "Load error"
  puts x.message
  puts x.backtrace
end