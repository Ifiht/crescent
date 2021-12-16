#!/usr/bin/env ruby

me = __FILE__
child1 = rand(1..9)
child2 = rand(10..99)
child3 = rand(100..999)


system( "cat #{me} > ./eden/#{child1}.rb" )
system( "cat #{me} > ./eden/#{child2}.rb" )
system( "cat #{me} > ./eden/#{child3}.rb" )


system( "rm #{me}" )


if true
    exit(2147483647)
elsif false
    exit(13)
else
    exit(1)
end