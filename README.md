# Mailcheck - Ruby

The Ruby library that suggests a right domain when your users misspell it in an email address. See the original at https://github.com/mailcheck/mailcheck.

When your user types in "user@hotnail.con", Mailcheck will suggest "user@hotmail.com".

Mailcheck will offer up suggestions for top level domains too, and suggest ".com" when a user types in "user@hotmail.cmo".

## Installation

Add this line to your application's Gemfile:

    gem 'mailcheck'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mailcheck

## Usage

```ruby
> require 'mailcheck'

> mailcheck = Mailcheck.new
> mailcheck.suggest("user@hotma.com")
# => {
#   :address =>"user",
#   :domain  =>"hotmail.com",
#   :full    =>"user@hotmail.com"
# }
```

Returns false if no suggestion:
```ruby
> mailcheck.suggest("user@hotmail.com")
# => false
```

Pass in a custom list of domains and TLDs:
```ruby
mailcheck = Mailcheck.new(
  :domains => ["gmail.com", "hotmail.com", "aol.com"],
  :top_level_domains => ["com", "net", "org"]
)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

* [This gist](https://gist.github.com/mmmaia/3715790), by [mmmaia](https://github.com/mmmaia) - an initial port to Ruby

Maintainers
-------

- [Scott Becker](https://github.com/sbecker), Author.

License
-------

Licensed under the MIT License.
