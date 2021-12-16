#!/usr/bin/env ruby

me = __FILE__
child1 = rand(500..999)
child2 = rand(100..499)

system( "cat #{me} > ./eden/#{child1}.rb" )
system( "cat #{me} > ./eden/#{child2}.rb" )

system( "rm #{me}" )

exit(2147483647)