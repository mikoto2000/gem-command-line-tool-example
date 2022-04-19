# frozen_string_literal: true

require "test_helper"

class TestHello < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Hello::VERSION
  end

  def test_hello
    assert "Hello, World!" == Hello.hello
  end
end
