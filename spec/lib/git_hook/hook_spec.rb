require 'spec_helper'
require 'git_hook/hook'

describe GitHook::Hook do
  it ".gem_name" do
    GitHook::Hook.gem_name('Bundler::SetUp').should == 'bundler-set_up'
  end

  it ".class_name" do
    GitHook::Hook.class_name('bundler-set_up').should == 'Bundler::SetUp'
  end
end
