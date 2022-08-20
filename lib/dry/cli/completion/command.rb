# frozen_string_literal: true

require "dry/cli/completion"

module Dry
  class CLI
    module Completion
      class Command < Dry::CLI::Command
        desc "Print tab completion script for given shell"

        example [
          "bash # Print tab completion script for bash",
          "zsh # Print tab completion script for zsh",
          "-a bash # Include command aliases for bash"
        ]

        option :include_aliases, required: true, type: :boolean, default: false, aliases: ["a"],
          desc: "Include command aliases when true"
        argument :shell, required: false, type: :string, values: Dry::CLI::Completion::SUPPORTED_SHELLS,
          desc: "Shell for which to print the completion script"

        def call(shell:, include_aliases: false, **)
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
