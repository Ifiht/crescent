#!/usr/bin/env ruby

MUUPPER =  2000
MULOWER = -2000
MUFACTOR = 333

class Lifeform
    attr_reader :threadid, :filename, :contents, :duration, :exitcode
    attr_accessor :threadid, :filename, :contents, :duration, :exitcode
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
num_lifeforms_initial = system( "ls -l ./eden/*.rb | wc -l" ).to_s.chomp.to_i
num_lifeforms_final = 0
num_mutations = 0
num_deaths = 0


def delete_char(str)
    n = str.length
    return str
end

def insert_char(str)
    n = str.length
    return str
end

def duplicate_line(arr)
    n = arr.count
    return arr
end

def delete_line(arr)
    n = arr.count
    return arr
end

def mutate(slurp)
    s = slurp
    return s
end

    
Dir.foreach('./eden') do |rufile|
    if rufile.to_s.match?(/.*\.rb/)
        f = rufile.to_s
        c = File.read("./eden/#{f}")
        t = Thread.new { Thread.current[:exitcode] = system( "ruby ./eden/#{f} && echo $?" ).to_s.chomp.to_i }
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
    if life.exitcode != 0
        system( "rm ./eden/#{life.filename}" )
        num_deaths += 1
    end
end

num_lifeforms_final = system( "ls -l ./eden/*.rb | wc -l" ).to_s.chomp.to_i

puts "#========== NAYRU stats ==========#"
puts "# Number of initial forms: #{num_lifeforms_initial}"
puts "# Number of current forms: #{num_lifeforms_final}"
puts "# Number of forms destroyed: #{num_deaths}"
