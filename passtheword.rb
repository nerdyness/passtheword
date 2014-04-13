#!/usr/bin/env ruby

require './lib/hashme.rb'

fail "usage: #{$0} plain-text-password" if $*.empty?

extend Hashme
message = ""
$*.each { |string| message << string }
puts "The password will be in your paste buffer for the next #{self.timeout} seconds. Go!"
self.hash2clipboard(message, self.salt)
