# frozen_string_literal: true

module Dry
  class CLI
    module Completion
      require_relative "completion/version"
      require_relative "completion/generator"

      SUPPORTED_SHELLS = [
        BASH = "bash",
        ZSH = "zsh"
      ]
    end
  end
end
