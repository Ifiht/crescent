#!/usr/bin/env ruby
# Comment
# Block
# At
# Beginning

require 'digest'

me = __FILE__

md5 = Digest::MD5.hexdigest me.to_s

mynum = me.match(/^[0-9]+/).to_s.to_i


a = [1, 2, 3, 4, 5]

s = "And the earth was without form, and void; and darkness was upon the face of the deep"

i = 2147483647

h = { :x => 10, :y => 20, :z => 30 }


child1 = rand(1..999)

"eden2147483647/#{child1}.rb" == me.to_s ? child1 += 1 : nil

child2 = rand(1..999)
"eden2147483647/#{child2}.rb" == me.to_s ? child2 += 1 : nil

child3 = rand(1..999)

"eden2147483647/#{child3}.rb" == me.to_s ? child3 += 1 : nil


system( "cat #{me} > ./eden2147483647/#{child1}.rb" )

system( "printf '\n##{md5}' >> ./eden2147483647/#{child1}.rb" )

system( "cat #{me} > ./eden2147483647/#{child2}.rb" )

system( "printf '\n##{md5}' >> ./eden2147483647/#{child2}.rb" )

system( "cat #{me} > ./eden2147483647/#{child3}.rb" )

system( "printf '\n##{md5}' >> ./eden2147483647/#{child3}.rb" )


if true
    
    exit(251)
    
elsif false
    
    exit(13)
    
else
    
    exit(2)
    
end
#23dd6c6ce8d7c64ccc540000e57e146a
#3d541bb2e9468c0e5dc4aea490eedbae