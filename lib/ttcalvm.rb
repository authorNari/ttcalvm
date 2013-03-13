require 'bundler'
Bundler.require(:default)
require_relative 'ttcalvm/generator'
require_relative 'ttcalvm/nodes'

Treetop.load File.dirname(__FILE__) + "/ttcalvm/grammar.tt"

module Ttcalvm
  class ParserError < RuntimeError; end

  def self.compile(code)
    generator = Generator.new
    parser = TtcalvmParser.new

    if node = parser.parse(code)
      node.compile(generator)
    else
      raise ParserError, parser.failure_reason
    end
    
    generator
  end
end
