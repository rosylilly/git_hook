require 'spec_helper'
require 'git-hook'

describe GitHook do
  its(:git_dir) {
    subject.to_s.should == Pathname.new('.git').expand_path.to_s
  }
end
