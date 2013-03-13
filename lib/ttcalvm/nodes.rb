module Ttcalvm
 class ::Treetop::Runtime::SyntaxNode
    def value
      text_value
    end
    
    def codegen(context)
    end
  end
  Node = Treetop::Runtime::SyntaxNode

  class Adjective < Node
    def compile(g)
      r = codegen(g)
      g.finish(r)
    end

    def codegen(g)
      res = multitive.codegen(g)
      return res if elements.size == 1
      return elements.last.elements.inject(res) do |r, i|
        case i.op.value
        when "+"
          g.add(r, i.multitive.codegen(g))
        when "-"
          g.sub(r, i.multitive.codegen(g))
        end
      end
    end
  end

  class Multitive < Node
    def codegen(g)
      r = primary.codegen(g)
      return r if elements.size == 1
      return elements.last.elements.inject(r) do |r, i|
        case i.op.value
        when "*"
          g.mul(r, i.primary.codegen(g))
        when "/"
          g.sdiv(r, i.primary.codegen(g))
        when "%"
          g.odd(r, i.primary.codegen(g))
        end
      end
    end
  end

  class Primary < Node
    def codegen(g)
      expression.codegen(g)
    end
  end

  class Number < Node
    def codegen(g)
      g.new_number(value.to_i)
    end
  end
end
