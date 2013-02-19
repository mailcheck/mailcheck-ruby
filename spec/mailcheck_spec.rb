require 'spec_helper'

describe Kicksend::Mailcheck do

  before do
    @mailcheck = Kicksend::Mailcheck.new
  end

  describe "#suggest" do
    it "returns a hash of the address, domain, and full email address when there's a suggestion" do
      suggestion = @mailcheck.suggest("user@hotma.com")

      suggestion[:address].should == 'user'
      suggestion[:domain].should  == 'hotmail.com'
      suggestion[:full].should    == 'user@hotmail.com'
    end

    it "is false when there's no suggestion" do
      @mailcheck.suggest("user@hotmail.com").should be_false
    end

    it "is false when an imcomplete email is provided" do
      @mailcheck.suggest("contact").should be_false
    end

  end

end