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
	BruteForce::Generator.new(letters: BruteForce::ALPHA_NUMERIC, filter: nil, starts_from: '')

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

#####Code

```ruby
require 'brute_force'
require 'digest/md5'
require 'benchmark'

BruteForce::Generator.new(letters: BruteForce::LOWER_ALPHA_NUMERIC | BruteForce::SYMBOL, starts_from: 'lolaaaa').tap do |g|
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

#####Output
```
Status    | Word        | Hash                                  | Number of attempts
-------------------------------------------------------------------------------------
Searching | lold4f[     | 043f3b74588a7cd039a73b6590acd0dd      | 1000000
Searching | lolf~l#     | 8d7d3e5f5091b433421ae171e89763c0      | 2000000
Searching | loli^rj     | 84c5997b9d3ebc71c7a9010ed161a37c      | 3000000
Searching | loll>x      | 40777367a79b9644702a03addf130542      | 4000000
Searching | lolo."-     | e8e72e1eea1f1315bf5f622da7241354      | 5000000
Searching | lolr((t     | 5dddefb07d81393a535da22d6a809ff0      | 6000000
Searching | lolu".9     | 827e73d722c4631623a1ff8e973d1072      | 7000000
Searching | lolxw=[     | 1269a5f1e373f6882f4aa9df61ff5153      | 8000000
Searching | lol q]#     | 979dfab06b4c4b0c804bd81736052c4e      | 9000000
Searching | lol#k}j     | e30345d498bef4aeaf6a5733d42e199d      | 10000000
-------------------------------------------------------------------------------------
Found     | lol$123     | c68ab9687ec94f924c6548671d646e1b      | 10245334
-------------------------------------------------------------------------------------
 71.234000   0.000000  71.234000 ( 71.357751)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/xire28/brute_force.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

