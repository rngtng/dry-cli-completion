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

Add the completion command to you existing commands like:

```

```

## Development


For local development, this project comes with a Dockerimage and Makefile. After checking out the repo, run the following to enter development console:

```
make build dev
```

Then, run `rspec` to run the tests.

To release a new version, update the version number in `version.rb`, push commits to GitHub and then create a release. This will create a git tag for the version, and push the `.gem` file to [rubygems.org](https://rubygems.org) as well as GitHub packages.
See GitHub actions for more.

