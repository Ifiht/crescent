#!/usr/bin/env ruby

me = __FILE__
child1 = rand(500..999)
child2 = rand(100..499)

system( "cat #{me} > #{child1}.rb" )
system( "cat #{me} > #{child2}.rb" )

if me.to_s.include?("a.rb")
else
    system( "rm #{me}" )
end

exit(90874329411493)