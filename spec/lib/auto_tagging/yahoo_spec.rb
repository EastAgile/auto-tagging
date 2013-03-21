require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "AutoTagging::Yahoo" do
  describe "#get_tags" do
    let(:main) { AutoTagging::Yahoo.new }

    context "yahoo service return an invalid response" do
      before(:each) { main.stub(:service_request).and_return("") }
      it "should return empty array" do
        main.get_tags(long_content).should == []
      end
    end

    context "empty content" do
      it "should return empty array" do
        main.get_tags(empty_content).should == []
      end
    end

    context "not empty content" do
      it "should return an array" do
        main.get_tags(long_content).should_not be_empty
      end

      context "complex content" do
        it "should return an array" do
          main.get_tags(complex_content).should_not be_empty
        end
      end

      context "url search" do
        context "invalid url" do
          let(:opts) { {:url => "not a valid url"} }

          it "should return an empty array" do
            main.get_tags(opts).should == []
          end
        end

        context "valid url" do
          let(:opts) { {:url => "http://www.bbc.co.uk/"} }

          it "should return an array" do
            main.get_tags(opts).should_not be_empty
          end
        end

      end
    end
  end
end
