class Window
    include Enumerable

    def initialize(back, start_index, length)
        @back = back
        @start_index = start_index
        @length = length
    end

    private def iteration_indexes
        @start_index...(@start_index + length)
    end

    attr_reader :length

    def [](i, len = nil)
        return @back[i % length + @start_index] unless len

        # todo - validate lengths here
        Window.new(@back, i + @start_index, len)
    end

    def []=(i, value)
        @back[i % length + @start_index] = value
    end

    def each
        iteration_indexes.each do |i|
            yield @back[i]
        end
    end

    def map!(&block)
        raise ArgumentError, 'cant do enum stuff yet' unless block

        case block.arity
        when 0
            iteration_indexes.each do |i|
                @back[i] = yield
            end
        when 1
            iteration_indexes.each do |i|
                @back[i] = yield @back[i]
            end
        when 2
            iteration_indexes.each do |i|
                @back[i] = yield @back[i], i
            end
        end
    end
end

def Array.to_w
    Window.new(self, 0, length)
end

def Enumerable.in_windows(window_count = 1)
    window_size = 1 + count / window_count
    Enumerator.new do |y|
        n = 0
        while n < count
            len = [count - n, window_size].min
            y << Window.new(self, n, len)
            n += window_size
        end
    end
end