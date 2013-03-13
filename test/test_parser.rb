class Parser < Test::Unit::TestCase
  def setup
    @parser =  TtcalvmParser.new
  end

  def test_parse
    assert_equal "1", @parser.parse("1").value
    assert_equal "11", @parser.parse("(11)").multitive.primary.expression.multitive.primary.value

    # 1+1
    code = "1+1"
    assert_equal "1", @parser.parse(code).multitive.primary.value
    assert_equal "+", @parser.parse(code).elements.last.elements.first.op.value

    # 1+1+1
    code = "1+1+1"
    assert_equal "1", @parser.parse(code).multitive.primary.value
    assert_equal "+", @parser.parse(code).elements.last.elements.first.op.value
    assert_equal "+", @parser.parse(code).elements.last.elements[1].op.value
  end
end
