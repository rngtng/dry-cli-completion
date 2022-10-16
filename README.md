# Dry::CLI::Completion

[![Gem Version](https://badge.fury.io/rb/dry-cli-completion.svg)](https://badge.fury.io/rb/dry-cli-completion)

---

[Dry::CLI](https://github.com/dry-rb/dry-cli) extension & drop-in Command to generate a completion
script for bash/zsh. It heavily relies on the great work of https://github.com/dannyben/completely.

---

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
The gems architecture consits of three layers which each abstracts & simplifies the completion script generation and its usage:

1. Command layer - drop-in dry-cli command to print the completion script for given shell
2. Generator layer - the actual script generation leveraging [completely](https://github.com/dannyben/completely)
3. Input layer - interspecting the dry-cli registry to extract each command with it options, arguements and aliases

### 1. Command layer
Simplest usage is to drop in the `Dry::CLI::Completion::Command` to your existing registry:

```ruby
module MyRegistry
  extend Dry::CLI::Registry

  register "cmd1", MyCmd1
  #....

  register "completion", Dry::CLI::Completion::Command[self]
end
```

or extend the registry subsequently:

```ruby
#....
MyRegistry.register("completion", Dry::CLI::Completion::Command[MyRegistry])
```

This will extend your cli for a new command `completion` with following usage:

```sh
Usage:
  foo-cli completion [SHELL]

Description:
  Print tab completion script for given shell

Arguments:
  SHELL                             # Shell for which to print the completion script: (bash/zsh)

Options:
  --[no-]include-aliases, -a        # Include command aliases when true, default: false
  --help, -h                        # Print this help

Examples:
  foo-cli completion bash # Print tab completion script for bash
  foo-cli completion zsh # Print tab completion script for zsh
  foo-cli completion -a bash # Include command aliases for bash
```

### 2. Generator Layer
In case you want to change/extend the completion script, create a custom command and leverage just the generator:

```ruby
class MyCommand < Dry::CLI::Command
  desc "Custom completion script command"

  def call(**)
    script = Dry::CLI::Completion::Generator.new(MyRegistry).call(shell: "bash")
    # ... further processing here ...
    puts script
  end
end
```

### 3. Input layer
Lastly, if the script generation input needs to be adjusted, leverage the input layer. Here the commands, arguments, options and their values/types extracted and put in an input format for `completely`. See [completely Readme](https://github.com/dannyben/completely) for details.

```ruby
input = Dry::CLI::Completion::Input.new(MyRegistry, "foo").call(include_aliases: false)
# ... further processing here ...
puts Completely::Completions.new(input)
```

## Development
For local development, this project comes dockerized - with a Dockerimage and Makefile. After checking out the repo, run the following to enter development console:

    $ make build dev

With that, any dependencies are maintained and no ruby version manager is required.

### Testing
The gem comes with a full-fledged rspec testsuite. To execute all tests run in developer console:

    $ rspec

### Manual Testing
The `Foo::CLI::Command` registry used in unit test is available as `spec/foo-cli` for manual testing. First source the completion script:

    $ source <(spec/foo-cli completion bash)

Then try the tab completion yourself:

```sh
$ spec/foo-cli <tab>
completion  echo        exec        help        start       stop        version
```

### Linting
For liniting, the gem leverages the [standard Readme](https://github.com/testdouble/standard)  and [rubocop](https://github.com/rubocop/rubocop) rules. To execute just run:

    $ rubocop

### Releasing
To release a new version, update the version number in `version.rb`, push commits to GitHub and then create a release. This will create a git tag for the version, and push the `.gem` file to [rubygems.org](https://rubygems.org) as well as GitHub packages.
See GitHub actions in `.github` for more.

## Supported Ruby versions

This library officially supports the following Ruby versions:

* MRI `>= 2.7.0`

## License

See `LICENSE` file.
