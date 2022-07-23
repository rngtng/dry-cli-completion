# Dry::Cli::Completion

Dry::CLI Command to generate a completion script for bash/zsh

[![Gem Version](https://badge.fury.io/rb/dry-cli-completion.svg)](https://badge.fury.io/rb/dry-cli-completion)

## About

Extension Command for Dry::CLI which generates a completion script for bash/zsh.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dry-cli-completion'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install dry-cli-completion

## Usage

TODO: Write usage instructions here

## Development


For local development, this project comes with a Dockerimage and Makefile. After checking out the repo, run the following to enter development console:

```
make build dev
```

Then, run `rake spec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).
