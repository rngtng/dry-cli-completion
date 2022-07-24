# frozen_string_literal: true

require_relative "lib/dry/cli/completion/version"

Gem::Specification.new do |spec|
  spec.name = "dry-cli-completion"
  spec.version = Dry::Cli::Completion::VERSION
  spec.authors = ["rngtng"]
  spec.email = ["tobi@rngtng.com"]
  spec.licenses = ["MIT"]

  spec.summary = "Dry::CLI Command to generate a completion script for bash/zsh"
  spec.description = "Extension Command for Dry::CLI which generates a completion script for bash/zsh."
  spec.homepage = "https://github.com/rngtng/dry-cli-completion"
  spec.required_ruby_version = ">= 2.7.6"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/rngtng/dry-cli-completion"
  spec.metadata["changelog_uri"] = "https://github.com/rngtng/dry-cli-completion/CHANGELOG.md"

  spec.files = Dir["lib/**/*"] + %w(Gemfile LICENSE README.md CHANGELOG.md dry-cli-completion.gemspec)
  spec.require_paths = ["lib"]

  spec.add_dependency "completely", "~> 0.4"
end
