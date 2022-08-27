class Vec
    def initialize(*args)
        @data = args.freeze
        @arity = args.count
    end

    attr :arity, :data

    def self.[](*args)
        new(*args.map(&:to_r))
    end

    def [](i)
        raise ArgumentError unless i >= 0 && i < arity

        @data[i]
    end

    def []=(i, value)
        raise ArgumentError unless i >= 0 && i < arity
        @data[i] = value
    end

    def +(other) = data.zip(other.to_vec.data).map { _1 + _2 }.to_v

    def -(other) = data.zip(other.to_vec.data).map { _1 - _2 }.to_v

    def *(scalar) = data.map { _1 * scalar }.to_v

    def /(scalar) = data.map { _1 / scalar }.to_v

    def dot(other) = data.zip(other.to_vec.data).map { _1 * _2 }.sum

    def project_onto(other)
        other = other.to_vec
        other * ((self.dot(other))/(other.dot(other)))
    end

    def inspect = "(#{data.map(&:inspect).join(",")})"

    def ==(other) = data == other.data
    alias eql? ==

    def hash = data.hash

    def to_vec = self
end

class Array
    def to_vec = Vec.new(*self)
end
