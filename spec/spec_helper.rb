# -*- encoding: utf-8 -*-
require 'rubygems'
require 'rspec'

Dir.glob("#{File.expand_path(File.dirname(__FILE__))}/../lib/**/*").each {|l| require l }

class Hash
  def except(*keys)
    clone.except!(*keys)
  end
  def except!(*keys)
    keys.map! { |key| convert_key(key) } if respond_to?(:convert_key)
    keys.each { |key| delete(key) }
    self
  end
end