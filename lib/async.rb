require 'fork'

module Enumerable
    def fork(&block)
        map { |*args| Fork.future { block.call(*args) } }.map(&:call)
    end
end
