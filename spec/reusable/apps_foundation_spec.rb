require File.expand_path("../../spec_helper", __FILE__)
require 'reusable/apps_foundation'

module DummyProject
  extend Reusable::AppsFoundation
end

describe Reusable::AppsFoundation do
  subject do
    DummyProject
  end

  describe ".apps" do
    it "by default is an empty array" do
      subject.apps.should == []
    end
  end

  describe ".load_apps" do
    it "loads list of registered apps from given directory" do
      subject.apps += %w(dummy)
      subject.expects(:require).with('/tmp/dummy/app.rb')
      subject.load_apps('/tmp')
    end
  end
end
