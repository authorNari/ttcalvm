require 'llvm'
require 'llvm/core'
require 'llvm/execution_engine'

module Ttcalvm
  class Generator
    include LLVM
    extend Forwardable

    def initialize(mod = LLVM::Module.new("ttcalvm"), function=nil)
      LLVM.init_x86
      @module = mod
      @printf = @module.functions.add("printf", [Pointer(LLVM::Int8)], Int, varargs: true)
      @function = function || @module.functions.add("main", [], Int)
      @entry_block = @function.basic_blocks.append("entry")
      @entry_builder = Builder.new
      @entry_builder.position_at_end(@entry_block)
    end

    def_delegators :@entry_builder, :add, :sub, :mul, :sdiv

    def odd(l, r)
      sub(l, mul(r, sdiv(l, r)))
    end

    def new_number(value)
      Int.from_i(value)
    end

    def to_file(io)
      @module.write_bitcode(io)
    end

    def dump
      @module.dump
    end

    def inspect
      @module.inspect
    end

    def run
      LLVM::JITCompiler.new(@module).run_function(@function)
    end

    def finish(res)
      @entry_builder.call(@printf, @entry_builder.global_string("%d\n"), res)
      @entry_builder.ret(Int.from_i(0))
    end
  end
end
