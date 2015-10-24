# SalesforceId [![Build Status](https://api.travis-ci.org/plataformatec/devise.svg?branch=master)](https://travis-ci.org/Fire-Dragon-DoL/salesforce_id.svg?branch=master) [![Code Climate](https://codeclimate.com/github/Fire-Dragon-DoL/salesforce_id/badges/gpa.svg)](https://codeclimate.com/github/Fire-Dragon-DoL/salesforce_id) [![Test Coverage](https://codeclimate.com/github/Fire-Dragon-DoL/salesforce_id/badges/coverage.svg)](https://codeclimate.com/github/Fire-Dragon-DoL/salesforce_id/coverage)

Gem to properly convert from and to 15 characters case sensitive format and
18 characters case insensitive format for salesforce record ID.

It's implemented as a C library to make the conversion as fast and performant
as possible.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'salesforce_id'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install salesforce_id

## Usage

The gem can be used as easily as:

```ruby
id15 = "003G000001SUbc4"
id18 = "003G000001SUbc4IAD"

# Convert to insensitive id, 18 characters
SalesforceId.to_insensitive(id15) == id18 # => true

# Convert to sensitive id, 15 characters
SalesforceId.to_sensitive(id18) == id15 # => true

# Check if salesforce id is valid
SalesforceId.valid?(id15)  # => true
SalesforceId.valid?(id18)  # => true
SalesforceId.valid?("foo") # => false

# Fixes casing for case-insensitive ids
SalesforceId.repair_casing(id18.downcase) == id18 # => true

# Check if id is case-sensitive format
SalesforceId.sensitive?(id15) # => true
SalesforceId.sensitive?(id18) # => false
SalesforceId.sensitive?(nil)  # => false

# Check if id is case-insensitive format
SalesforceId.insensitive?(id18) # => true
SalesforceId.insensitive?(id15) # => false
SalesforceId.insensitive?(nil)  # => false
```

## Documentation

Methods are documented in [salesforce_id_ext.h](https://github.com/Fire-Dragon-DoL/salesforce_id/blob/master/ext/salesforce_id/salesforce_id_ext.h), this file is
the only public API of the gem, everything else must be considered private.

## Links

Some useful links related to this Salesforce ID issue:

- [What are salesforce ids composed of](http://salesforce.stackexchange.com/questions/1653/what-are-salesforce-ids-composed-of)
- [How I can view 18 characters long Salesforce ID in reports?](https://success.salesforce.com/answers?id=90630000000gy8oAAA)
- [Why does 18-character ID casing matter in a SOQL WHERE clause?](http://salesforce.stackexchange.com/questions/50163/why-does-18-character-id-casing-matter-in-a-soql-where-clause)
- [Creating a link using an 18 character ID](http://salesforce.stackexchange.com/questions/9568/creating-a-link-using-an-18-character-id/9569#9569)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Fire-Dragon-DoL/salesforce_id.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

