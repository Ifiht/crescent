#!/usr/bin/env ruby

#====================<[ CONSTANT Declarations ]>==============#
LINETHRESH = 25
CHARTHRESH = 5
RBYCHSETCT = 61

#====================<[ Class definitions ]>==================#
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

#====================<[ Variable Initionalization ]>==========#
childs = []
ruby_charset = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 
'(', ')', '{', '}', '[', ']', '.', ',', '?', '/', '\\', '!', '#', '$', '@', '*', '&', '%', ' ', '|', '`', "\n",
'-', '+', '=', '*']
num_lifeforms_initial = 0
num_lifeforms_final = 0
num_mutations = 0
num_deaths = 0

#====================<[ RANDOM CHAR OPS ]>====================#
#+---------< Char Deletion
def delete_char(str, i)
    str_arr = str.split("")
    s1 = str_arr.count
    s2 = s1 - 1
    line_cha_sel = rand(0..s2)
    str_arr.delete_at(line_cha_sel)
    str = str_arr.join
    return str
end
#+---------< Char Insertion
def insert_char(str, i)
    str_arr = str.split("")
    s1 = str_arr.count
    s2 = s1 - 1
    line_cha_sel = rand(0..s2)
    str_arr[line_cha_sel] = ruby_charset[i]
    str = str_arr.join
    return str
end

#====================<[ RANDOM LINE OPS ]>====================#
#+---------< Line Duplication
def duplicate_line(arr1, i)
    arr2 = arr1.insert(i, arr1[i])
    return arr2
end
#+---------< Line Deletion
def delete_line(arr1, i)
    arr1.delete_at(i)
    return arr1
end

#====================<[ MUTATE FILE STRINGS ]>================#
def mutate(slurp)
    s = slurp.lines
    sn = s.count
    snf = sn - 1
    arr_rand_sel = rand(0..snf)
    rby_char_sel = rand(1..RBYCHSETCT)
    if m > 1
        insert_char(s[arr_rand_sel].to_s, rby_char_sel)
    end
    if m > CHARTHRESH
        delete_char(s[arr_rand_sel].to_s, rby_char_sel)
    end
    if m > LINETHRESH
        if m.even?
            delete_line(s, arr_rand_sel)
        else
            duplicate_line(s, arr_rand_sel)
        end
    end
    return s
end

#====================<[ MAIN PROGRAM BODY ]>==================#
#+---------< Get every file in Eden & give it a lifeform object
Dir.foreach('./eden') do |rufile|
    if rufile.to_s.match?(/.*\.rb/)
        f = rufile.to_s
        c = File.read("./eden/#{f}")
        t = Thread.new { Thread.current[:exitcode] = system( "ruby ./eden/#{f}" ) }
        l = Lifeform.new(t, f, c)
        childs << l
        num_lifeforms_initial += 1
    end
end
#+---------< Mutate the contents of every lifeform
childs.each do |mutant|
    s = mutate(mutant.contents)
    mutant.contents = s
end
#+---------< Join the threads, delete all parents
childs.each do |life|
    life.threadid.join
    if life.exitcode != 0
        system( "rm ./eden/#{life.filename}" )
        num_deaths += 1
    end
end
#+---------< Count what is left
Dir.foreach('./eden') do |rufile|
    if rufile.to_s.match?(/.*\.rb/)
        num_lifeforms_final += 1
    end
end
#+---------< Output epoch statistics
puts "#========== NAYRU stats ==========#"
puts "#  Number of initial forms: #{num_lifeforms_initial}"
puts "#  Number of current forms: #{num_lifeforms_final}"
puts "#          Forms destroyed: #{num_deaths}"
