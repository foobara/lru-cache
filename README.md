# Foobara::LruCache

A basic least-recently-used cache implementation

## Installation

Typical stuff: add `gem "foobara-lru-cache` to your Gemfile or .gemspec file. Or even just
`gem install foobara-lru-cache` if just playing with it directly in scripts.

## Usage

The usage is `cache.cached(key) { value_to_cache_when_no_cache_hit }`

An example:

```ruby
require "foobara/lru_cache"

cache = Foobara::LruCache.new

criteria = { name: "Fumiko" }

# This will actually run FindCapybara
record = cache.cached(criteria) do
  FindCapybara.run!(criteria)
end

puts record.name

# This will not run FindCapybara and will instead return the cached record
record = cache.cached(criteria) do
  FindCapybara.run!(criteria)
end

puts record.name
```

The default capacity is 10 but you can override this with `LruCache.new(100)` if you wanted a capacity of 100.

## Contributing

Bug reports and pull requests are welcome on GitHub
at https://github.com/foobara/lru-cache

## License

This project is dual licensed under your choice of the Apache-2.0 license and the MIT license.
Please see LICENSE.txt for more info.
