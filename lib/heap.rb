class Heap
    class Min < Heap
        protected def sorted?(i, j) 
            a = @sort_by.call(@data[i])
            b = @sort_by.call(@data[j])
            (a <=> b) <= 0
        end
    end
    class Max < Heap
        protected def sorted?(i, j) 
            a = @sort_by.call(@data[i])
            b = @sort_by.call(@data[j])
            (a <=> b) >= 0
        end
    end

    def initialize(from, sort_by: nil)
        @data = from
        @sort_by = (sort_by || :itself).to_proc

        return if from.length.zero?

        for i in ((@data.length-1) / 2).downto 0
            down i
        end
    end

    def self.[](*data) = new(data)

    def insert(value)
        @data.push value
        up @data.length - 1
        nil
    end

    def pop
        raise 'out of elements' unless @data.length > 0

        swap(0, @data.length - 1)
        out = @data.pop
        down 0
        out
    end

    def drain
        arr = []
        arr << pop until @data.length.zero?
        arr
    end

    def inspect
        @data.inspect
    end

    private def swap(i, j)
        @data[i], @data[j] = @data[j], @data[i]
    end

    private def up(i)
        while true
            return if i.zero?
            return if sorted?(i/2, i)

            swap(i, i/2)
            i = i/2
        end
    end

    private def down(i)
        while true
            lhs_i = i*2 + 1
            rhs_i = i*2 + 2

            return if lhs_i >= @data.length

            if rhs_i >= @data.length
                swap(i, lhs_i) unless sorted?(i, lhs_i)
                return
            end

            lhs_sorted = sorted?(i, lhs_i)
            rhs_sorted = sorted?(i, rhs_i)
            return if lhs_sorted && rhs_sorted

            if rhs_sorted
                swap(i, lhs_i)
                i = lhs_i
                next
            end

            if lhs_sorted
                swap(i, rhs_i)
                i = rhs_i
                next
            end

            if sorted?(lhs_i, rhs_i)
                swap(i, lhs_i)
                i = lhs_i
            else
                swap(i, rhs_i)
                i = rhs_i
            end
        end
    end
end
