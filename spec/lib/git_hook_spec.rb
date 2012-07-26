require 'spec_helper'
require 'git_hook'

describe GitHook do
  its(:repo_dir) {
    subject.to_s.should == Pathname.new(Dir.pwd).expand_path.to_s
  }

  its(:git_dir) {
    subject.to_s.should == Pathname.new('.git').expand_path.to_s
  }

  its(:hooks_dir) {
    subject.to_s.should == Pathname.new('.git/hooks').expand_path.to_s
  }
end
