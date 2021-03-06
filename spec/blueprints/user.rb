# -*- encoding : utf-8 -*-
require 'reg_api2/entity/user'

RegApi2::Entity::User.blueprint(:bad_login) do
  user_login { nil }
  user_password { Faker::Internet.password }
  user_email { Faker::Internet.email }
  user_country_code { 'RU' }
end

RegApi2::Entity::User.blueprint(:bad_password) do
  user_login { Faker::Name.first_name }
  user_password { nil }
  user_email { Faker::Internet.email }
  user_country_code { 'RU' }
end

RegApi2::Entity::User.blueprint(:bad_email) do
  user_login { Faker::Name.first_name }
  user_password { Faker::Internet.password }
  user_email { nil }
  user_country_code { 'RU' }
end

RegApi2::Entity::User.blueprint(:bad_country_code) do
  user_login { Faker::Name.first_name }
  user_password { Faker::Internet.password }
  user_email { Faker::Internet.email }
  user_country_code { nil }
end

RegApi2::Entity::User.blueprint(:good_user) do
  user_login { 'autotestlogin4532' }
  user_password { Faker::Internet.password }
  user_email { Faker::Name.first_name + '@mail.ru' }
  user_country_code { 'RU' }
  user_first_name { Faker::Name.first_name }
  user_last_name { Faker::Name.last_name }
  check_only { 1 }
end
