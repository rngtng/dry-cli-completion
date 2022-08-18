# frozen_string_literal: true

require_relative "input"
require "completely"

module Dry
  class CLI
    module Completion
      class Generator
        def initialize(registry, program_name: nil)
          @registry = registry
          @program_name = program_name || Dry::CLI::ProgramName.call
        end

        def call(shell: BASH, include_aliases: false, out: StringIO.new)
          if shell == ZSH
            out.puts "# enable bash completion support, see https://github.com/dannyben/completely#completions-in-zsh"
            out.puts "autoload -Uz +X compinit && compinit"
            out.puts "autoload -Uz +X bashcompinit && bashcompinit"
          end

          out.puts Completely::Completions.new(
            Input.new(@registry, @program_name).call(include_aliases: include_aliases)
          ).script
          out.string
        end
      end
    end
  end
end
