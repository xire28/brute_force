require 'test_helper'

class BruteForceTest < Minitest::Test
  def test_has_a_version_number
    refute_nil ::BruteForce::VERSION
  end

  def test_starts_with_option
    generator = ::BruteForce::Generator.new(starts_from: 'abcdef')
    assert_equal(generator.next, 'abcdef')
  end

  def test_letters_option
    generator = ::BruteForce::Generator.new(letters: BruteForce::UPPERCASE)
    generator.next #skip empty string (\0)
    assert_equal(generator.next, 'A')
  end

  def test_regex_filter_option
    pattern = /\A.*?B\Z/
    generator = ::BruteForce::Generator.new(filter: pattern)
    assert_match(pattern, generator.next)
  end

  def test_lambda_filter_option
    generator = ::BruteForce::Generator.new(filter: ->(word){ word.start_with?('B') })
    assert_equal(generator.next, 'B')
  end
end
