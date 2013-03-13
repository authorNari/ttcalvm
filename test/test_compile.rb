class TestCompile < Test::Unit::TestCase
  def test_compile
    code = "(1 + 1) * 2 * (2 * 9)"
    assert_kind_of Ttcalvm::Generator, Ttcalvm.compile(code)
    Ttcalvm.compile(code).dump
    Ttcalvm.compile(code).run
  end
end
