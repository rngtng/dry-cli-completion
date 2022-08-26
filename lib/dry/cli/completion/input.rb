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
          commands = extract_commands(root_node, include_aliases: include_aliases)
          commands.each_with_object({
            @program_name => commands.keys.map(&:first).uniq + ["help"]
          }) do |(name, config), input|
            input_line(input, "#{@program_name} #{name.join(" ")}", config[:arguments].shift, config)
          end
        end

        private

        def extract_commands(parent_node, include_aliases:, prefix: [])
          nodes = parent_node.children.dup
          nodes.merge!(parent_node.aliases.dup) if include_aliases

          nodes.each_with_object({}) do |(name, sub_node), hash|
            key = prefix.dup << name
            hash[key] = if sub_node.command
              command(sub_node.command, include_aliases: include_aliases)
            elsif sub_node.children
              hash.merge!(extract_commands(sub_node, include_aliases: include_aliases, prefix: key))
              {
                options: {},
                arguments: [
                  ["subcommands", sub_node.children.keys]
                ]
              }
            end
          end
        end

        def root_node
          @registry.get({}).instance_variable_get(:@node)
        end

        def command(command, include_aliases: false)
          {
            options: {
              "--help" => []
            },
            arguments: command.arguments.map { |arg|
              [arg.name, argument_values(arg)]
            }
          }.tap do |hash|
            command.options.each do |opt|
              hash[:options]["--#{opt.name}"] = option_values(opt)
              next unless include_aliases
              opt.aliases.each { |arg|
                hash[:options]["-#{arg}"] = option_values(opt)
              }
            end
          end
        end

        def argument_values(argument)
          return ["<file>"] if argument.name.to_s.include?("path")
          return argument.values if argument.values
          nil
        end

        def option_values(option)
          return ["<file>"] if option.name.to_s.include?("path")
          return option.values if option.values
          return [] if option.type != :boolean
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
