# REG.API 2 for Ruby

[![Gem Version](https://badge.fury.io/rb/reg.api2.png)](http://badge.fury.io/rb/reg.api2)
[![build status](https://secure.travis-ci.org/regru/reg_api2-ruby.png)](https://travis-ci.org/regru/reg_api2-ruby)
[![Code Climate](https://codeclimate.com/github/regru/reg_api2-ruby.png)](https://codeclimate.com/github/regru/reg_api2-ruby)
[![Coverage Status](https://coveralls.io/repos/regru/reg_api2-ruby/badge.png?branch=master)](https://coveralls.io/r/regru/reg_api2-ruby)

REG.API v2 Implementation.

We want to note that Ruby client uses recommended way to access API: POST requests with JSON input/output in utf-8 encoding over HTTPS protocol.

This code hosted on [GitHub](https://github.com/regru/reg_api2-ruby).

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

Other examples available as examples of concrete method calls.

### Console

This gem also provides `regapi2console` utility that allows You
to query REG.API interactively using `irb` shell.

```
$ regapi2console
Your default username: "test", and You can change it with "~/.regapi2".
1.9.3-p194 :001 > folder.nop
 => {"name"=>"test_folder_name", "id"=>"-1"}
1.9.3-p194 :002 >
```

## Recommendations for effective use of REG.API
This section provides information that will help you to make you work with REG.API more productive and convenient.

One of the most frequent problems our partners face when working with REG.API is exceeding the maximum request limit (1,200 requests per hour).

The analysis of such situations showed that in most cases such problems are the results of improper use or misuse of REG.API due to bugs or design faults in the software used by partners.

The recommendations below will, on the one hand, allow you to preclude situations with excessive requests to REG.API leading to temporary blocking of user accounts, and, on the other hand, to reduce the load on RegRuSRS.

1. We recommend you to send WHOIS requests (for the display of WHOIS data on your sites) not to REG.API, but directly to the WHOIS servers of the corresponding domain zones.

  The advantages of this approach are as follows:
  * The responses to WHOIS requests will arriver faster.
  * You will get data directly from its source without mediation.
  * The overall number of requests will decrease, thus the likelihood of blocking of your account due to excessive requests to REG.API decreases as well.

  We can offer you ready-to-use software solutions that will allow you to optimize your procedures of getting WHOIS data.

2. We recommend you to use REG.API for placing orders or changing data rather than for obtaining data. The software employed by some of our partners either do not locally store domain-related data or store incomplete data. As a result this data is dynamically downloaded from our system with the help of such functions domain_list, service/get_info, domain/get_contacts, domain/get_nss, etc.
  We advise you to store all domain- and service-related locally and address to REG.API only when you want to change some data in the registry. This will ensure fast and reliable operation of your applications and minimize your dependency on the availability of our system.

3. All data change requests should be performed asynchronously.

  Some applications perform domain/service registration operations, as well as data change operations right at the moment of processing HTTP requests from clients. But if the execution of an API request fails for some reason (connection loss, exceeding of request limit, parallel request blocking), this request will get lost and the client will receive an error message.

  This mode of interaction is very unreliable and inconvenient for your customers.

  We recommend you to perform all service ordering/data changing requests asynchronously using the queue mechanism. In such a case:
  * You will exclude the possibility of API request blockings (because only one API request is performed at a time).
  * In case of connection failures the request can be repeated until it is executed (this significantly increases the system reliability).
  * In case of request processing errors (if REG.RU returned an error code), you can fix the problem and repeat the request, while the customer will not get any error messages. You can solve the major part of your customers’ problems on your own without their participation.

4. It is a good practice to keep logs of all API request and responses. If a problem arises, logs will help you or our support engineers to efficiently locate and solve it.

We hope that this information will be useful for you and that it will help you to optimize your work with REG.API.

## REG.API 2.0 overview

### Service identification parameters
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

### Service list identification parameters

| Parameter   | Description                     |
| ----------- | ------------------------------- |
| domains | A list where each element includes a domain name or its service_ID in compliance with common service identification parameters. You can specify not more than 1000 services in one request. |
| services | A list where each element includes a domain name + service type or service_ID in compliance common service identification parameters. |

### Folder identification parameters

| Parameter   | Description                     |
| ----------- | ------------------------------- |
| folder_id | Numeric folder identifier (recommended). |
| folder_name | Folder name. |

### Common payment options

This section describes the parameters common for the functions dealing with service ordering or renewal of services, i.e. the functions that involve payments.

| Parameter   | Description                     |
| ----------- | ------------------------------- |
| point_of_sale | An arbitrary string that identifies a system/web site used by the customer for placing an order for a domain. Optional field. Example: «regpanel.ru». |
| pay_type | Payment option. Currently available payment options: (WM, bank, pbank, prepay, yamoney, rapida, robox, paymer, cash, chronopay). Default value: prepay. Please note that automatic payments can be done only if the selected payment method is «prepay» and you have enough funds in your account. Otherwise, your order will be marked as unpaid and you will have to arrange the payment manually from your profile page. |
| ok_if_no_money | Enable to create bill when not enough funds to complete the operation. In this case requested operation is stored in the system, however it will be processed after submitting "change payment method" request via web interface. Return error if this flag not set and not enough funds to complete the operation. |

## Documentation

Actual documentation available at https://www.reg.com/support/help/API-version2

For developers: Ruby client documentation can be accessed as:

```bash
bundle exec rake yard
open doc/index.html
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add your tests and run `rake`.
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
