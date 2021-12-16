#!/usr/bin/env ruby

class Lifeform
    attr_reader :threadid, :filename, :contents, :duration, :exitcode
    def initialize(threadid, filename, contents)
        @threadid = threadid
        @filename = filename
        @contents = contents
        @duration = 0
        @exitcode = 0
    end
end


childs = []
ruby_charset = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 
'(', ')', '{', '}', '[', ']', '.', ',', '?', '/', '\\', '!', '#', '$', '@', '*', '&', '%', ' ', '|', '`',
'-', '+', '=', '*']


def delete_char(str)
    n = str.length
end

def insert_char(str)
    n = str.length
end

def duplicate_line(arr)
    
end

def delete_line(arr)
    
end

def mutate(slurp)
    s = slurp
    return s
end

    
Dir.foreach('./eden') do |rufile|
    if rufile.to_s.match?(/.*\.rb/)
        f = rufile.to_s
        c = File.read("./eden/#{f}")
        t = Thread.new { system( "ruby ./eden/#{f} && echo $?" ) }
        l = Lifeform.new(t, f, c)
        childs << l
    end
end


childs.each do |mutant|
    s = mutate(mutant)
    mutant.contents = s
end


childs.each do |life|
    life.threadid.join
end