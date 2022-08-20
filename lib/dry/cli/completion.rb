# frozen_string_literal: true

require_relative "completion/version"
require_relative "completion/generator"

module Dry
  class CLI
    module Completion
      SUPPORTED_SHELLS = [
        BASH = "bash",
        ZSH = "zsh"
      ]
    end
  end
end
