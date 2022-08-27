module Induction
    def induct(method_name)
        m = method(method_name)
        memo = {}
        inducting = false
        pr = ->(*args) do
            return memo[args] if memo.key? args

            raise Err, args if inducting
            stk = [args]
            inducting = true
            until stk.empty?
                begin
                    next_args = stk.pop
                    memo[next_args] ||= m.call(*next_args)
                rescue Err => e
                    stk.push(args)
                    stk.push(e.args)
                end
            end
            inducting = false

            memo[args]
        end
        define_method(method_name, &pr)
    end
    class Err < StandardError
        def initialize(args)
            @args = args
        end
        attr_reader :args
    end
end
