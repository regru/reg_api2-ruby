# REG.API 2 for Ruby

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

RegApi2.username = 'test'
RegApi2.password = 'test'
RegApi2.lang     = 'ru'

RegApi2.service.nop(services: [
  { dname: "test.ru" },
  { dname: "test.su", servtype: "srv_hosting_ispmgr" },
  { service_id: 111111 },
  { service_id: "22bug22" },
  { surprise: "surprise.ru" }
])
```

## Service identification parameters
This group of parameters serves for identification of specific pre-ordered services.

Services can be identified by:

* service ID (both domains and services),
* domain name (domains only),
* domain name and service type (services only),
* ID of a parent service, service type or subtype (services only).

Identification by numeric service identifiers is the most reliable and quick method. For this reason, we recommend that you save and store domain/service IDs on your side and use them for service identification.

| Parameter   | Description                     |
| ----------- | ------------------------------- |
| | **Identification by service ID (recommended)** |
| service_id  | Numeric service identifier. |
| | **Identification by service ID passed by the user** |
| user_servid | Alphanumeric service identifier. To use such an identifier, you should define it during domain/service creation. To learn the pre-defined identifier, use the `RegApi2.service.get_info` function.|
| | **Domain identification by name** |
| domain_name | Domain name. Russian domain names should be passed in the punycode or national encoding. |
| | **Service identification by domain name and type of service (except for VPS)** |
| domain_name | Name of the domain the service is associated with. Russian domain names should be passed in the punycode or national encoding. |
| servtype | Service type. For example, «srv_hosting_ispmgr» for hosting or «srv_webfwd» for the web-forwarding service. |
| | **Service identification by parent service ID, service type or subtype** |
| uplink_service_id | ID of the parent service with which the required service is associated. |
| servtype | Service type. For example, «srv_hosting_ispmgr» for hosting or «srv_webfwd» for the web-forwarding service. |
| subtype | Service subtype. For example, «pro» for the ISP Manager Pro license. | 


## Common payment options

* point_of_sale
  * An arbitrary string that identifies a system/web site used by the customer for placing an order for a domain. Optional field. Example: «regpanel.ru».
* pay_type
  * Payment option. Currently available payment options: (WM, bank, pbank, prepay, yamoney, rapida, robox, paymer, cash, chronopay).
  * Default value: prepay. Please note that automatic payments can be done only if the selected payment method is «prepay» and you have enough funds in your account. Otherwise, your order will be marked as unpaid and you will have to arrange the payment manually from your profile page.
* ok_if_no_money
  * Enable to create bill when not enough funds to complete the operation. In this case requested operation is stored in the system, however it will be processed after submitting "change payment method" request via web interface. Return error if this flag not set and not enough funds to complete the operation.

## Documentation

Simply do

```bash
bundle exec rake yard
open doc/index.html
```

Also documentation available at https://www.reg.com/support/help/API-version2

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
