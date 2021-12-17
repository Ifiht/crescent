#!/usr/bin/env ruby

#====================<[ CONSTANT Declarations ]>==============#
LINETHRESH = 20  # file must have more lines than this for line mutation to happen
CHARTHRESH = 5   # line must have more lines than this for char deletion to happen
RBYCHSETCT = 62  # number of elements in "ruby_charset" - KEEP UPDATED!!!

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
$ruby_charset = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0', # numbers
'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', # letters
'(', ')', '{', '}', '[', ']', '.', ',', '?', '/', '\\', '!', '#', '$', '@', '*', '&', '%', ' ', '|', '`', "\n", # special characters
'-', '+', '=', '*', '^'] # math operators
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
    str_arr[line_cha_sel] = $ruby_charset[i]
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
    if arr_rand_sel > 1
        s[arr_rand_sel] = insert_char(s[arr_rand_sel].to_s, rby_char_sel)
    end
    if arr_rand_sel > CHARTHRESH
        s[arr_rand_sel] = delete_char(s[arr_rand_sel].to_s, rby_char_sel)
    end
    if arr_rand_sel > LINETHRESH
        if arr_rand_sel.even?
            s = delete_line(s, arr_rand_sel)
        else
            s = duplicate_line(s, arr_rand_sel)
        end
    end
    return s.join
end

#====================<[ MAIN PROGRAM BODY ]>==================#
#+---------< Get every file in Eden & give it a lifeform object
Dir.foreach('./eden') do |rufile|
    if rufile.to_s.match?(/.*\.rb/)
        f = rufile.to_s
        c = File.read("./eden/#{f}")
        t = Thread.new { system( "ruby ./eden/#{f} > /dev/null 2>&1" ) }
        l = Lifeform.new(t, f, c)
        childs << l
        num_lifeforms_initial += 1
    end
end
#+---------< Mutate the contents of every lifeform
childs.each do |mutant|
    if mutant.contents == nil || mutant.contents == ""
        system( "rm ./eden/#{mutant.filename} > /dev/null 2>&1" )
        childs.delete(mutant)
    else
        s = mutate(mutant.contents)
        mutant.contents = s
        File.open("./eden/#{mutant.filename}", "w") { |f| 
            f.write mutant.contents.to_s # write the mutated contents back to file 
        }
    end
end
#+---------< Join the threads, delete all parents that didn't remove themselves
childs.each do |life|
    life.threadid.join
    if $? != nil || $?.exitstatus != nil
        life.exitcode = $?.exitstatus
    else
        life.exitcode = 255
    end
    #puts life.exitcode
    if life.exitcode != 251
        system( "rm ./eden/#{life.filename} > /dev/null 2>&1" )
        num_deaths += 1
    else
        puts "#{life.filename} offers prime 251!"
    end
end
system( "find ./eden -size  0 -print -delete > /dev/null 2>&1" ) # delete 0-byte childs 
#+---------< Count what is left
Dir.foreach('./eden') do |rufile|
    if rufile.to_s.match?(/.*\.rb/)
        num_lifeforms_final += 1
    end
end
#+---------< Output epoch statistics
puts "#========== epoch stats ==========#"
puts "#  Number of initial forms: #{num_lifeforms_initial}"
puts "#  Number of current forms: #{num_lifeforms_final}"
puts "#          Forms destroyed: #{num_deaths}"
