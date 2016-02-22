require 'brute_force/version'
require 'radix'

module BruteForce
	EMPTY = ["\0"]
	CONTROL = EMPTY | [*"\0".."\x1F"]
	LOWERCASE = EMPTY | [*'a'..'z']
	UPPERCASE = EMPTY | [*'A'..'Z']
	NUMERIC = EMPTY | [*'0'..'9']
	ASCII_SYMBOL = EMPTY | [*' '..'/', *':'..'@', *'['..'`', *'{'.."\x7F"]
	ASCII_EXTENDED = EMPTY | [*"\x80".."\xFF"]
	UNICODE = EMPTY | [*"\u007B".."\u00BF", *"\u02B0".."\u037F", *"\u2000".."\u2BFF"]

	LOWER_ALPHANUMERIC = NUMERIC | LOWERCASE
	UPPER_ALPHANUMERIC = NUMERIC | UPPERCASE
	ALPHANUMERIC = NUMERIC | LOWERCASE | UPPERCASE
	ASCII_PRINTABLE = ASCII_SYMBOL | ALPHANUMERIC
	ALL = CONTROL | ALPHANUMERIC | ASCII_SYMBOL | ASCII_EXTENDED | UNICODE

	class Generator
		def initialize(letters: ALPHANUMERIC, filter: nil, starts_from: '')
			self.letters = letters
			self.filter = filter
			self.counter = word_to_number(starts_from)
		end

		def next
			begin
				word = number_to_word(self.counter)
				self.counter+=1
			end while not allowed?(word)
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

		def allowed?(word)
			(filter.nil?)? true : (filter.is_a?(Regexp)? filter.match(word) : filter.call(word))
		end
	end
end
