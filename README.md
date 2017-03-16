# BruteForce

Simple, fast and highly configurable brute force generator for ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'brute_force'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install brute_force

## Usage

1. Require the gem

	```ruby
	require 'brute_force'
	```

2. Create an instance of the generator

	```ruby
	#default signature
	BruteForce::Generator.new(letters: BruteForce::ALPHANUMERIC, filter: nil, starts_from: '')

	BruteForce::Generator.new
	BruteForce::Generator.new(letters: BruteForce::LOWERCASE | ['-'])
	BruteForce::Generator.new(filter: /\A.*?B\Z/)
	BruteForce::Generator.new(filter: ->(word){ word.start_with?('B') })
	BruteForce::Generator.new(starts_from: 'aaaaaaaa')
	```

3. Iterate

	```ruby
	word = generator.next
	```

####Example

```ruby
require 'brute_force'
require 'digest/md5'
require 'benchmark'

BruteForce::Generator.new(letters: BruteForce::LOWER_ALPHANUMERIC | BruteForce::ASCII_SYMBOL, starts_from: 'lolaaaa').tap do |g|
	target_hash = 'c68ab9687ec94f924c6548671d646e1b'
	count = 0
	hr = '-' * 85
	puts Benchmark.measure {
		puts "Status\t  | Word\t| Hash\t\t\t\t\t| Number of attempts"
		puts hr
		begin
			count+=1
			attempt = g.next
			attempt_hash = Digest::MD5.hexdigest(attempt)
			puts "Searching | #{attempt}\t| #{attempt_hash}\t| #{count}" if count % 1000000 == 0
		end while attempt_hash != target_hash
		puts hr
		puts "Found\t  | #{attempt}\t| #{attempt_hash}\t| #{count}"
		puts hr
	}
end
```

####Output
```
Status    | Word        | Hash                                  | Number of attempts
-------------------------------------------------------------------------------------
Searching | lolc| )     | 40f14259308d216d91332fd1598b5998      | 1000000
Searching | lolf/_a     | f05b19bfe63fac31107a000bbe7adfa9      | 2000000
Searching | loli!i*     | a5f4c6425ec7e8e2126e008f7ae5b920      | 3000000
Searching | lollm)b     | 716555993d324cefc0ff7a6d4d8bf83a      | 4000000
Searching | lolo80+     | 670b92da3b79d23fc7162b0afdc5bc2b      | 5000000
Searching | lolq`rc     | 2a3a3e607480640e3ead5490d3388f8e      | 6000000
Searching | lolt-;,     | 1a90f2fde019f2e024e5940d08e26772      | 7000000
Searching | lolwz9d     | 22f9a3c1139d85becfbccc4a2d89d1e3      | 8000000
Searching | lolzkz-     | 6e1ceb0549bb2c535b0686c14a60ac43      | 9000000
Searching | lol"5^e     | 8da39ab9f8d8a021df908a0bfa5093db      | 10000000
-------------------------------------------------------------------------------------
Found     | lol$123     | c68ab9687ec94f924c6548671d646e1b      | 10691387
-------------------------------------------------------------------------------------
 73.062000   0.000000  73.062000 ( 73.156629)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/xire28/brute_force.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

