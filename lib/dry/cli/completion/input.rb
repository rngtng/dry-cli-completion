# frozen_string_literal: true

module Dry
  class CLI
    module Completion
      class Input
        def initialize(registry, program_name)
          @registry = registry
          @program_name = program_name
        end

        def call(include_aliases:)
          nodes = root_node.children.dup
          nodes.merge!(root_node.aliases.dup) if include_aliases

          commands = nodes.each_with_object({}) do |(name, sub_node), hash|
            next unless sub_node.command
            hash[name] = command(sub_node.command, include_aliases: include_aliases)
          end

          commands.each_with_object({
            @program_name => commands.keys + ["help"]
          }) do |(name, config), input|
            input_line(input, "#{@program_name} #{name}", config[:arguments].shift, config)
          end
        end

        private

        def root_node
          @registry.get({}).instance_variable_get(:@node)
        end

        def command(command, include_aliases: false)
          options = {
            "--help" => []
          }

          command.options.each do |o|
            options["--#{o.name}"] = values(o)
            o.aliases.each { |a| options["--#{a}"] = values(o) } if include_aliases
          end
          {
            options: options,
            arguments: command.arguments.map { |a| [a.name, values(a)] }
          }
        end

        def values(option_or_argument)
          return ["<file>"] if option_or_argument.name.to_s.include?("path")
          return option_or_argument.values if option_or_argument.values
          return [] if option_or_argument.type != :boolean
          nil
        end

        def input_line(input, name, argument, config)
          return if name.include?("<file>")
          if argument
            arg_values = argument.last || []
            input[name] = arg_values + config[:options].keys
            argument = config[:arguments].shift
            arg_values.each { |v| input_line(input, "#{name}*#{v}", argument, config) }
          else
            input[name] = config[:options].keys
          end
        end
      end
    end
  end
end
