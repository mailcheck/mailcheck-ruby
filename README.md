# Mailcheck

A ruby translation of the [Kicksend mailcheck](https://github.com/Kicksend/mailcheck) javascript library which suggests a right domain when your users misspell it in an email address.

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

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

* [Mailcheck.js](https://github.com/Kicksend/mailcheck): the original idea
* [This gist](https://gist.github.com/mmmaia/3715790), by [mmmaia](https://github.com/mmmaia) - an initial port to Ruby
