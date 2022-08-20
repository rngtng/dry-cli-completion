# frozen_string_literal: true

require_relative "../../../foo"

RSpec.describe Dry::CLI::Completion::Generator do
  subject do
    Dry::CLI::Completion::Generator.new(Foo::CLI::Commands).call(
      shell: "UNKNOWN"
    )
  end

  it "raises ArgumentError" do
    expect { subject }.to raise_error(ArgumentError)
  end
end
