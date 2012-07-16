require File.expand_path("../../spec_helper", __FILE__)

class DummyWithCallbacks
  include Reusable::Callbacks
  define_callbacks :on_error, :on_success

  def call(cond)
    if cond
      run_callback :on_success
    else
      run_callback :on_error, "Fuuu!"
    end
  end
end

describe Reusable::Callbacks do
  subject do
    DummyWithCallbacks.new
  end

  describe ".define_callback" do
    it "defines callback under specified name" do
      subject.should respond_to :on_error
      on_error = false
      subject.on_error { on_error = true }
      subject.callbacks[:on_error].call
      on_error.should be
    end
  end

  describe "#run_callback" do
    it "executes specified callback's chain" do
      on_error, on_success = false, false
      subject.on_error { |msg| on_error = "Fuuu!" }
      subject.on_success { on_success = true }
      subject.call(false)
      on_error.should == "Fuuu!"
      on_success.should_not be
    end
  end
end
