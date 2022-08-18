# frozen_string_literal: true

require "dry/cli/completion"

module Dry
  class CLI
    module Completion
      class Command < Dry::CLI::Command
        desc "Print tab completion script for bash or zsh"

        example [
          "# Print tab completion script for bash",
          "bash # Print tab completion script for bash",
          "zsh # Print tab completion script for zsh",
          "-a # Include command aliases for bash",
          "-a zsh # Include command aliases for zsh"
        ]

        option :include_aliases, required: false, type: :boolean, default: false, aliases: ["a"],
          desc: "Include command aliases when true"
        argument :shell, required: false, type: :string, default: Dry::CLI::Completion::BASH,
          values: [Dry::CLI::Completion::BASH, Dry::CLI::Completion::ZSH],
          desc: "Shell for which to print the completion script"

        def call(include_aliases: false, shell: Dry::CLI::Completion::BASH, **)
          puts Generator.new(self.class.registry).call(
            shell: shell,
            include_aliases: include_aliases
          )
        end

        def self.[](registry)
          @registry = registry
          self
        end

        class << self
          attr_reader :registry
        end
      end
    end
  end
end
