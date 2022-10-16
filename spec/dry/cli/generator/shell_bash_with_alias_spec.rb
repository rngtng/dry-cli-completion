# frozen_string_literal: true

require_relative "../../../foo"

RSpec.describe Dry::CLI::Completion::Generator do
  subject do
    Dry::CLI::Completion::Generator.new(Foo::CLI::Commands).call(
      shell: Dry::CLI::Completion::BASH,
      include_aliases: true
    )
  end

  it "returns completion script for bash with aliases" do
    is_expected.to include <<~SCRIPT
      _rspec_completions() {
        local cur=${COMP_WORDS[COMP_CWORD]}
        local compwords=("${COMP_WORDS[@]:1:$COMP_CWORD-1}")
        local compline="${compwords[*]}"

        case "$compline" in
          'completion'*'bash')
            while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_rspec_completions_filter "--help --include_aliases -a")" -- "$cur" )
            ;;

          'generate config'*)
            while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_rspec_completions_filter "--help --apps")" -- "$cur" )
            ;;

          'completion'*'zsh')
            while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_rspec_completions_filter "--help --include_aliases -a")" -- "$cur" )
            ;;

          'generate test'*)
            while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_rspec_completions_filter "--help --framework")" -- "$cur" )
            ;;

          'completion'*)
            while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_rspec_completions_filter "bash zsh --help --include_aliases -a")" -- "$cur" )
            ;;

          '--version'*)
            while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_rspec_completions_filter "--help")" -- "$cur" )
            ;;

          'generate'*)
            while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_rspec_completions_filter "config test")" -- "$cur" )
            ;;

          'g config'*)
            while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_rspec_completions_filter "--help --apps")" -- "$cur" )
            ;;

          'version'*)
            while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_rspec_completions_filter "--help")" -- "$cur" )
            ;;

          'g test'*)
            while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_rspec_completions_filter "--help --framework")" -- "$cur" )
            ;;

          'start'*)
            while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_rspec_completions_filter "--help")" -- "$cur" )
            ;;

          'echo'*)
            while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_rspec_completions_filter "--help")" -- "$cur" )
            ;;

          'stop'*)
            while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_rspec_completions_filter "--help --graceful")" -- "$cur" )
            ;;

          'exec'*)
            while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_rspec_completions_filter "--help")" -- "$cur" )
            ;;

          '-v'*)
            while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_rspec_completions_filter "--help")" -- "$cur" )
            ;;

          'v'*)
            while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_rspec_completions_filter "--help")" -- "$cur" )
            ;;

          'g'*)
            while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_rspec_completions_filter "config test")" -- "$cur" )
            ;;

          *)
            while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_rspec_completions_filter "version echo start stop exec completion generate v -v --version g help")" -- "$cur" )
            ;;

        esac
      } &&
      complete -F _rspec_completions rspec

      # ex: filetype=sh
    SCRIPT
  end
end
