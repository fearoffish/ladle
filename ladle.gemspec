# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
 
require 'ladle/version'
 
Gem::Specification.new do |s|
  s.name        = "ladle"
  s.version     = Ladle::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jamie van Dyke"]
  s.email       = ["jamie@fearoffish.com"]
  s.homepage    = "http://github.com/fearoffish/ladle"
  s.summary     = "The best way to start clusters of ec2 servers"
  s.description = "Start clusters of ec2 servers with a single configuration file"
 
  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "ladle"
 
  s.add_development_dependency "rspec"
 
  s.files        = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md ROADMAP.md CHANGELOG.md)
  s.executables  = ['ladle']
  s.require_path = 'lib'
end