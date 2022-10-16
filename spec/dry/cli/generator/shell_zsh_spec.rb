# frozen_string_literal: true

require_relative "../../../foo"

RSpec.describe Dry::CLI::Completion::Generator do
  subject do
    Dry::CLI::Completion::Generator.new(Foo::CLI::Commands).call(shell: Dry::CLI::Completion::ZSH)
  end

  it "returns completion script for zsh" do
    is_expected.to include <<~SCRIPT
      # enable bash completion support, see https://github.com/dannyben/completely#completions-in-zsh
      autoload -Uz +X compinit && compinit
      autoload -Uz +X bashcompinit && bashcompinit
    SCRIPT
  end
end
