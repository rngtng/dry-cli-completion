# frozen_string_literal: true

require_relative "completion/version"
require_relative "completion/generator"

module Dry
  class CLI
    module Completion
      BASH = "bash"
      ZSH = "zsh"
    end
  end
end
