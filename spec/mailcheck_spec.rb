require 'spec_helper'

describe Mailcheck do

  before do
    @domains = ['yahoo.com', 'yahoo.com.tw', 'google.com','hotmail.com', 'gmail.com', 'emaildomain.com', 'comcast.net', 'facebook.com', 'msn.com', 'gmx.com']
    @top_level_domains = ['co.uk', 'com', 'org', 'info']
    @mailcheck = Mailcheck.new
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

  describe "cases" do
    it "passes" do
      mailcheck = Mailcheck.new :domains => @domains, :top_level_domains => @top_level_domains

      mailcheck.suggest('test@emaildomain.co')[:domain].should == 'emaildomain.com'
      mailcheck.suggest('test@gmail.con')[:domain].should == 'gmail.com'
      mailcheck.suggest('test@gnail.con')[:domain].should == 'gmail.com'
      mailcheck.suggest('test@GNAIL.con')[:domain].should == 'gmail.com'
      mailcheck.suggest('test@#gmail.com')[:domain].should == 'gmail.com'
      mailcheck.suggest('test@comcast.com')[:domain].should == 'comcast.net'
      mailcheck.suggest('test@homail.con')[:domain].should == 'hotmail.com'
      mailcheck.suggest('test@hotmail.co')[:domain].should == 'hotmail.com'
      mailcheck.suggest('test@fabecook.com')[:domain].should == 'facebook.com'
      mailcheck.suggest('test@yajoo.com')[:domain].should == 'yahoo.com'
      mailcheck.suggest('test@randomsmallcompany.cmo')[:domain].should == 'randomsmallcompany.com'
      mailcheck.suggest('test@yahoo.com.tw').should be_false
      mailcheck.suggest('').should be_false
      mailcheck.suggest('test@').should be_false
      mailcheck.suggest('test').should be_false

      # This test is for illustrative purposes as the splitEmail function should return a better
      # representation of the true top-level domain in the case of an email address with subdomains.
      # mailcheck will be unable to return a suggestion in the case of this email address.
      #
      mailcheck.suggest('test@mail.randomsmallcompany.cmo').should be_false
    end
  end

end