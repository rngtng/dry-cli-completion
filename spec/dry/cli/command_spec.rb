# frozen_string_literal: true

require_relative "../../foo"

RSpec.describe Dry::CLI::Completion::Command do
  subject do
    Dry::CLI.new(Foo::CLI::Commands).call(arguments: arguments)
  end

  let(:arguments) { %w[completion] }

  it "prints script to stdout" do
    expect { subject }.to output(/'completion'\*'bash'/).to_stdout
  end

  it "prints NOT with zsh adjustments to stdout" do
    expect { subject }.to_not output(/autoload -Uz \+X bashcompinit && bashcompinit/).to_stdout
  end

  it "prints NOT script with aliases to stdout" do
    expect { subject }.to_not output(/'v'\*\)/).to_stdout
  end

  context "when zsh given" do
    let(:arguments) { %w[completion zsh] }

    it "prints script with zsh adjustments to stdout" do
      expect { subject }.to output(/autoload -Uz \+X bashcompinit && bashcompinit/).to_stdout
    end
  end

  context "when with include alises given" do
    let(:arguments) { %w[completion -a] }

    it "prints script with aliases to stdout" do
      expect { subject }.to output(/'v'\*\)/).to_stdout
    end
  end
end
