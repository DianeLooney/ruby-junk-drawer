require './lib'
require 'benchmark'

#`go build -buildmode=c-shared -o goFuncs.so goFuncs.go`
#
#require 'ffi'
#
#module GoFuncs
#  extend FFI::Library
#  ffi_lib './goFuncs.so'
#  attach_function :GoIntSlice, [:int, :int, :int, :int], :int
#  attach_function :GoAdd, [:int, :int], :int
#end
#puts GoFuncs.GoIntSlice(1,2,3,4)
#puts GoFuncs.GoAdd(41, 1)


arr = (1..400_000_000).to_a

Benchmark.bm do |bm|
    bm.report("fork 20:") { arr.in_windows(20).fork { _1.map(&:odd?).tally }.collect(&:merge) }
    bm.report("fork  8:") { arr.in_windows(8) .fork { _1.map(&:odd?).tally }.collect(&:merge) }
    bm.report("fork  4:") { arr.in_windows(4) .fork { _1.map(&:odd?).tally }.collect(&:merge) }
    bm.report("fork  2:") { arr.in_windows(2) .fork { _1.map(&:odd?).tally }.collect(&:merge) }
    bm.report("fork  1:") { arr.in_windows(1) .fork { _1.map(&:odd?).tally }.collect(&:merge) }
    bm.report("forksum:") { Fork.return { arr.map(&:odd?).tally } }
    bm.report("map  50:") { arr.in_windows(50).map { _1.map(&:odd?).tally }.collect(&:merge) }
    bm.report("map   8:") { arr.in_windows(8) .map { _1.map(&:odd?).tally }.collect(&:merge) }
    bm.report("sum    :") { arr.map(&:odd?).tally }
end
