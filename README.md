# git-hook

git hooks management command line tool.

## Installation

in global:

    $ gem install git-hook

in project local:

    $ echo "gem 'git-hook'" >> Gemfile

    $ bundle install

use

    $ git hook --version

## Usage

write .githooks file:

    pre_commit 'GitHook::Hooks::RubySyntaxCheck', :require => 'git_hook/hooks/ruby_syntax_check'

and run it:

    $ git hook apply

