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

or with including of [RegApi2](http://regru.github.io/reg_api2-ruby/RegApi2.html) module:

```ruby
require "reg_api2"

include RegApi2

service.nop(services: [
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

Console use test/test credentials by default, but you can assign new ones
before any operations over REG.API through {RegApi2} properties.

Also console reads `~/.regapi2` configuration file if exists, to assign properties from. It knows about these properties in configuration file: `username`, `password`, `lang`, `pem`, `pem_password` and `ca_cert_path`. Properties should be written in `key=value` format separated by newline.

## API categories map

Please follow these links to view documentation on methods of all known API categories:

| Category | Description |
| -------- | ----------- |
| [common](http://regru.github.io/reg_api2-ruby/RegApi2/Common.html) | Common ops |
| [domain](http://regru.github.io/reg_api2-ruby/RegApi2/Domain.html) | Domain registration etc. |
| [user](http://regru.github.io/reg_api2-ruby/RegApi2/User.html) | User creation etc. |
| [service](http://regru.github.io/reg_api2-ruby/RegApi2/Service.html) | Generic service ops |
| [bill](http://regru.github.io/reg_api2-ruby/RegApi2/Bill.html) | Billing |
| [folder](http://regru.github.io/reg_api2-ruby/RegApi2/Folder.html) | Folders for services including domains |
| [zone](http://regru.github.io/reg_api2-ruby/RegApi2/Zone.html) | Domain zone resource records (DNS) |
| [hosting](http://regru.github.io/reg_api2-ruby/RegApi2/Hosting.html) | Jelastic hosting ops at now |

## Recommendations for effective use of REG.API

This section provides information that will help you to make you work with REG.API more productive and convenient.

One of the most frequent problems our partners face when working with REG.API is exceeding the maximum request limit (1,200 requests per hour for user/ip). Both limits are acting at the same time. If the limits has exceeded then REG.API sets the error code (depends on kind of) to `IP_EXCEEDED_ALLOWED_CONNECTION_RATE` or `ACCOUNT_EXCEEDED_ALLOWED_CONNECTION_RATE`, that raised by client as exception of {RegApi2::ApiError} class.

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

4. Use bulk operations whenever possible. A lot of methods support operations over lists of services and domains at once.

5. It is a good practice to keep logs of all API request and responses. If a problem arises, logs will help you or our support engineers to efficiently locate and solve it.

We hope that this information will be useful for you and that it will help you to optimize your work with REG.API.

## REG.API 2.0 overview

### General interaction principles

Each call of a function is atomic and synchronous, i.e. all requests are independent. All operations are also synchronous: the result of an operation returns immediately, there are no any intermediate stages during execution of operations. The choice in favor of this interaction method was made to simplify the customers’ work flow with REG.API.

Parallel processing of calls is available to requests not changing balance of the client on the account of REG.API provider.

### Method accessibility

All REG.API methods can be divided into categories of accessibility. On Ruby documentation accessibility marked by note. At the moment the following categories of accessibility present:

| Category | Description |
|----------|-------------|
| everyone | All methods tagged by this one are accessible to all users. Those methods does not require authentication before call. |
| clients  | This tag indicates the methods which accessible only for users registered on REG.API provider. Strongly required an authenticated API request. |
| partners | Group of methods which accessible only for partners (resellers) of the REG.API provider (REG.RU LLC). Actually, partners (resellers) able to execute all methods of the REG.API without any restrictions. |

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

### Common error codes

Error code from REG.API raised by client as exception of {RegApi2::ApiError} class. Test its `message` or `to_s` to know what happens.

| Error_code | Description |
|------------|-------------|
| | **Authorization errors** |
| NO_USERNAME | Username is not specified. |
| NO_AUTH | Method of authorization is not determined (probably, the password or signature fields are not found). |
| PASSWORD_AUTH_FAILED | Password authentification failed. |
| RESELLER_AUTH_FAILED | This function is available only for the Partners. |
| ACCESS_DENIED | Your access to the API is blocked, please refer to the technical support. |
| PURCHASES_DISABLED | Buying/selling is forbidden for the given account. |
| | **Errors of domains, services, folders identification** |
| DOMAIN_NOT_FOUND | Domain `domain_name` is not found, or you are not the owner. |
| SERVICE_NOT_FOUND | Service `servtype` for domain `domain_name` is not found. |
| SERVICE_NOT_SPECIFIED | Error of the service identification. |
| SERVICE_ID_NOT_FOUND | Service `service_id` is not found, or you are not the owner. |
| NO_DOMAIN | domain_name is not specified or blank |
| INVALID_DOMAIN_NAME_FORMAT | Format domain_name is not valid or domain is in unserviced TLD. |
| INVALID_SERVICE_ID | Format of service_id is not valid.
| INVALID_DOMAIN_NAME_PUNYCODE | The value of punycode for domain_name is not valid. |
| BAD_USER_SERVID | Invalid value for user_servid. |
| USER_SERVID_IS_NOT_UNIQUE | Non-unique field value user_servid at service/domain order. |
| TOO_MANY_OBJECTS_IN_ONE_REQUEST | Too many objects are indicated (more than 1000) in one request. |
| | **Accessibility errors** |
| SERVICE_UNAVAILABLE | Reg.API is temporarily unavailable |
| BILLING_LOCK | You have another active connection for financial operation to Reg.API |
| DOMAIN_BAD_NAME | Not valid name: `domain_name` |
| DOMAIN_BAD_NAME_ONLYDIGITS | Domain registration, which name contains only numbers is not acceptable for the given TLD |
| HAVE_MIXED_CODETABLES | It is unacceptable to mix national and Latin letters in the domain name |
| DOMAIN_BAD_TLD | Domain registration with `tld` extension is not available |
| TLD_DISABLED | Domain registration with `tld` extension is disabled |
| DOMAIN_NAME_MUSTBEENG | National letters are unacceptable in the domain name for the given extension (`tld`) |
| DOMAIN_NAME_MUSTBERUS | Latin letters are unacceptable in the domain name for the given extension (`tld`) |
| DOMAIN_ALREADY_EXISTS | The domain already exists, check via whois. |
| DOMAIN_INVALID_LENGTH | Invalid length of the domain name, you have entered either too short or too long name |
| DOMAIN_STOP_LIST | Unacceptable name, this domain is reserved, or it’s a premium-domain, which is offered at a special price |
| DOMAIN_STOP_PATTERN | Unfortunately, it’s impossible to register the name (`domain_name`) |
| FREE_DATE_IN_FUTURE | Domain’s release date of `domain_name` will be in future, AFTER the next date of the mass domain release |
| NO_DOMAINS_CHECKED | You haven’t selected any domain for registration |
| NO_CONTRACT | Filing an application for pre-term domain name registration is not possible after release before signing your contract about domain registration |
| INVALID_PUNYCODE_INPUT | Incorrect punycode name (error at the process of coding into Punycode) |
| CONNECTION_FAILED | Unable to check status of the domain: Can not connect the server. Please, try again later. |
| DOMAIN_ALREADY_ORDERED | Domain name `domain_name` has been already ordered by you before, You can pay for it, and the application for registration shall be done. |
| DOMAIN_EXPIRED | Unfortunately, the period of domain delegation of `domain_name` either has expired or will expire in the nearest future |
| DOMAIN_TOO_YOUNG | Unfortunately, less than 60 days have passed from the moment of domain `domain_name` registration, try to transfer the domain later |
| CANT_OBTAIN_EXPDATE | Impossible to determine the date of the domain delegation of `domain_name` |
| DOMAIN_CLIENT_TRANSFER_PROHIBITED | Domain `domain_name` is prohibited for transfer, contact the previous registrar to unlock the domain |
| DOMAIN_TRANSFER_PROHIBITED_UNKNOWN | Domain `domain_name` is prohibited for transfer by the upstream registrar, contact Technical Support for details |
| DOMAIN_REGISTERED_VIA_DIRECTI | Automatic transfer of the domain name `domain_name` within DirectI is prohibited |
| NOT_FOUND_UNIQUE_REQUIRED_DATA | The data for checking the uniqueness are not found: dname, servtype or user_id |
| ORDER_ALREADY_PAYED | Order on `dname` `servtype` is already payed |
| DOUBLE_ORDER | You already have not payed order on `dname` `servtype` |
| DOMAIN_ORDER_LOCKED | The order of the domain is disabled since processing of other order for the same domain isn't completed yet |
| UNAVAILABLE_DOMAIN_ZONE | `tld` is unavailable domain zone |
| | **Errors at working with DNS servers** |
| DOMAIN_IS_NOT_USE_REGRU_NSS | This domain does not use the DNS-server of REG.RU |
| REVERSE_ZONE_API_NOT_SUPPORTED | Configuring of reverse zones are currently not supported |
| ZONES_VARY | The domains in the list have different TLD configurations |
| IP_INVALID | Error in IP address. |
| SUBD_INVALID | Invalid subdomain |
| CONFLICT_CNAME | It’s impossible to indicate CNAME logs for a single subdomain together with other logs |
| | **Other errors** |
| NO_SUCH_COMMAND | Command `command_name` is not found |
| HTTPS_ONLY | Access to API via an unsecured interface (http) is prohibited! Please, use https. |
| PARAMETER_MISSING | `param`('s) is (are) not found.
| PARAMETER_INCORRECT | `param` has incorrect format or data. |
| NOT_ENOUGH_MONEY | Not enough money at account for this operation. |
| INTERNAL_ERROR | Internal error: `error_details`, inform the developers. |
| SERVICE_OPERATIONS_DISABLED | Service operations are prohibited |
| UNSUPPORTED_CURRENCY | Currency is not supported in the given system |

## Documentation

Actual documentation available at https://www.reg.com/support/help/api2

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
