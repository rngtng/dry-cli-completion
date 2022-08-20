# frozen_string_literal: true

RSpec.describe Dry::CLI::Completion::Input do
  subject(:input) do
    Dry::CLI::Completion::Input.new(registry, program_name)
  end

  let(:registry) do
    Module.new.tap do |mod|
      mod.extend Dry::CLI::Registry
    end
  end
  let(:program_name) { "foo" }

  describe ".call" do
    subject do
      input.call(include_aliases: include_aliases)
    end

    let(:include_aliases) { false }

    it do
      is_expected.to eq({
        program_name => ["help"]
      })
    end

    context "when registry contains command" do
      let(:command) { Class.new(Dry::CLI::Command) }

      before do
        registry.register "command", command, aliases: ["alias"]
      end

      it do
        is_expected.to eq({
          "foo" => ["command", "help"],
          "foo command" => ["--help"]
        })
      end

      context "when include_aliases is true" do
        let(:include_aliases) { true }

        it do
          is_expected.to eq({
            "foo" => ["command", "alias", "help"],
            "foo command" => ["--help"],
            "foo alias" => ["--help"]
          })
        end
      end

      context "when command has argument" do
        let(:name) { "a1" }
        let(:values) { nil }

        before do
          command.argument name, type: :string, values: values, aliases: [:aa1]
        end

        it do
          is_expected.to eq({
            "foo command" => ["--help"],
            "foo" => ["command", "help"]
          })
        end

        context "when argument name is path" do
          let(:name) { "path" }

          it do
            is_expected.to eq({
              "foo command" => ["<file>", "--help"],
              "foo" => ["command", "help"]
            })
          end
        end

        context "when argument values are given" do
          let(:values) { %w[v1 v2] }

          it do
            is_expected.to eq({
              "foo command" => ["v1", "v2", "--help"],
              "foo command*v1" => ["--help"],
              "foo command*v2" => ["--help"],
              "foo" => ["command", "help"]
            })
          end

          context "when multiple arguments with values are given" do
            before do
              command.argument "a2", type: :string, values: %w[v3 v4]
            end

            it do
              is_expected.to eq({
                "foo command" => ["v1", "v2", "--help"],
                "foo command*v1" => ["v3", "v4", "--help"],
                "foo command*v1*v3" => ["--help"],
                "foo command*v1*v4" => ["--help"],
                "foo command*v2" => ["v3", "v4", "--help"],
                "foo command*v2*v3" => ["--help"],
                "foo command*v2*v4" => ["--help"],
                "foo" => ["command", "help"]
              })
            end
          end
        end

        context "when include_aliases is true" do
          let(:include_aliases) { true }

          it do
            is_expected.to eq({
              "foo alias" => ["--help"],
              "foo command" => ["--help"],
              "foo" => ["command", "alias", "help"]
            })
          end
        end
      end

      context "when command has option" do
        let(:name) { "o1" }
        let(:type) { :string }
        let(:values) { nil }

        before do
          command.option name, type: type, values: values, aliases: [:ao1]
        end

        it do
          is_expected.to eq({
            "foo command" => ["--help", "--o1"],
            "foo" => ["command", "help"]
          })
        end

        context "when option name is path" do
          let(:name) { "path" }

          it do
            is_expected.to eq({
              "foo command" => ["--help", "--path"],
              "foo" => ["command", "help"]
            })
          end
        end

        context "when option type is boolean" do
          let(:type) { :boolean }

          it do
            is_expected.to eq({
              "foo command" => ["--help", "--o1"],
              "foo" => ["command", "help"]
            })
          end
        end

        context "when option values are given" do
          let(:values) { %w[v1 v2] }

          # TODO: implement me
          xit do
            is_expected.to eq({
              "foo command" => ["--help", "--o1"],
              "foo command*--o1" => ["v1", "v2"],
              "foo command*--o1*v1" => ["--help"],
              "foo command*--o1*v2" => ["--help"],
              "foo" => ["command", "help"]
            })
          end
        end

        context "when include_aliases is true" do
          let(:include_aliases) { true }

          it do
            is_expected.to eq({
              "foo command" => ["--help", "--o1", "-ao1"],
              "foo alias" => ["--help", "--o1", "-ao1"],
              "foo" => ["command", "alias", "help"]
            })
          end
        end
      end
    end
  end
end
