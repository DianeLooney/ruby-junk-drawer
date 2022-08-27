require 'minitest'
require './lib/induction'

extend Induction
induct def fib(n)
    return 0 if n == 0
    return 1 if n == 1

    fib(n-1) + fib(n-2)
end
puts "fib(600) = #{fib(600) % 1_000_009}" unless fib(600) % 1_000_009 == 612221
