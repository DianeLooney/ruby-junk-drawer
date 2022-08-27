class Tree
    attr :root

    class Node
        def initialize(value)
            @value = value
            @height = 0
        end

        attr :value
        def leaf? = (lhs.nil? && rhs.nil?)
        def root? = parent.nil?
        def inner? = (!leaf? && !root?)

        protected attr :height, :parent, :lhs, :rhs

        def lhs=(node)
            if lhs.nil?
                @lhs.parent = nil
                @lhs = nil
                set_height
                return
            end

            if lhs
                lhs.parent = nil
            end

            @lhs = node
            @lhs.parent = self
            set_height
        end

        def rhs=(node)
            if node.nil?
                @rhs.parent = nil
                @rhs = nil
                return
            end

            if rhs
                rhs.parent = nil
            end

            @rhs = node
            @rhs.parent = self
            set_height
        end
    end
end
