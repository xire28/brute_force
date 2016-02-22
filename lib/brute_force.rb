require 'brute_force/version'
require 'radix'

module BruteForce
	EMPTY = ["\0"]
	LOWERCASE = EMPTY | [*'a'..'z']
	UPPERCASE = EMPTY | [*'A'..'Z']
	NUMERIC = EMPTY | [*'0'..'9']
	SYMBOL = EMPTY | [*' '..'/', *':'..'@', *'['..'`', *'{'..'~']
	UNICODE = EMPTY | [*"\u007B".."\u00BF", *"\u02B0".."\u037F", *"\u2000".."\u2BFF"]

	LOWER_ALPHA_NUMERIC = NUMERIC | LOWERCASE
	UPPER_ALPHA_NUMERIC = NUMERIC | UPPERCASE
	ALPHA_NUMERIC = NUMERIC | LOWERCASE | UPPERCASE
	ALL = ALPHA_NUMERIC | SYMBOL | UNICODE

	class Generator
		def initialize(letters: ALPHA_NUMERIC, filter: nil, starts_from: '')
			self.letters = letters
			self.filter = filter
			self.counter = word_to_number(starts_from)
		end

		def next
			begin
				word = number_to_word(self.counter)
				self.counter+=1
			end while !filter.nil? && (filter.is_a?(Regexp)? !filter.match(word) : !filter.call(word))
			word
		end

		protected
		attr_accessor :letters, :filter, :counter

		def word_to_number(word)
			word.split('').map{|code| letters.find_index(code)}.b(letters.length).to_i
		end

		def number_to_word(number)
			number.b(letters.length).to_a(letters).join
		end
	end
end
