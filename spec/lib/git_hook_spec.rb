require 'spec_helper'
require 'git_hook'

describe GitHook do
  its(:git_dir) {
    subject.to_s.should == Pathname.new('.git').expand_path.to_s
  }

  its(:hooks_dir) {
    subject.to_s.should == Pathname.new('.git/hooks').expand_path.to_s
  }
end
