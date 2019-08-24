# SXS

[![Build Status](https://travis-ci.org/wbotelhos/sxs.svg)](https://travis-ci.org/wbotelhos/sxs)
[![Gem Version](https://badge.fury.io/rb/sxs.svg)](https://badge.fury.io/rb/sxs)
[![Maintainability](https://api.codeclimate.com/v1/badges/cc5efe8b06bc1d5e9e8a/maintainability)](https://codeclimate.com/github/wbotelhos/sxs/maintainability)
[![Patreon](https://img.shields.io/badge/donate-%3C3-brightgreen.svg)](https://www.patreon.com/wbotelhos)

SNS and SQS Wrapper.

## Install

Add the following code on your `Gemfile` and run `bundle install`:

```ruby
gem 'sxs'
```

Run the following task to create a SXS migration:

```bash
rails g sxs:install
```

## Usage

```ruby
SXS::Publisher.new('sqs_url', provider: :sqs).publish(body: 'value')
SXS::Publisher.new('sns_url', provider: :sns).publish(body: 'value')
SXS::Publisher.new('some_key', provider: :redis).publish(body: 'value')
SXS::Publisher.new('some_key', provider: :memory).publish(body: 'value')
```

If you do not specify the `provider` you will get:

```ruby
development: :redis
production: ArgumentError
test: :memory
```
