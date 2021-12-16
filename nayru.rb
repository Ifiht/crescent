#!/usr/bin/env ruby

class Song
    def initialize(threadid, filename)
        @threadid = threadid
        @filename = filename
        @duration = 0
        @exitcode = 0
    end
end


threads = []


Dir.foreach('./eden') do |rufile|
    if rufile.to_s.match?(/.*\.rb/)
         threads << Thread.new { puts rufile }
    end
end


threads.each(&:join)