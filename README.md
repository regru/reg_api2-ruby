# Reg.api2

[![build status](https://secure.travis-ci.org/regru/reg_api2-ruby.png)](https://travis-ci.org/regru/reg_api2-ruby)
[![Code Climate](https://codeclimate.com/github/regru/reg_api2-ruby.png)](https://codeclimate.com/github/regru/reg_api2-ruby)
[![Coverage Status](https://coveralls.io/repos/regru/reg_api2-ruby/badge.png?branch=master)](https://coveralls.io/r/regru/reg_api2-ruby)

REG.API v2 Implementation.

## Installation

Add this line to your application's Gemfile:

    gem 'reg.api2'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install reg.api2

## Usage

### List of services by specified identifiers

```ruby
require "reg_api2"

RegApi2.service.nop(services: [
  { dname:"test.ru" },
  { dname: "test.su", servtype: "srv_hosting_ispmgr" },
  { service_id: 111111 },
  { service_id: "22bug22" },
  { surprise: "surprise.ru" }
])
```

## Documentation

Simply do

```bash
bundle exec rake yard
open doc/index.html
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
