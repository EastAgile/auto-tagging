require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "AutoTagging::Alchemy" do
  let(:main) { AutoTagging::Alchemy.new }
  before(:each) { AutoTagging::Alchemy.api_key = key }

  describe "#get_tags" do
    context "invalid key" do
      let(:key) { 'invalid_key' }

      it "should return an empty array" do
        main.get_tags(empty_content).should == []
      end
    end

    context "valid key" do
      let(:key) { "e0d4cf69ba90640704a9f831b69b6ec7531142fe" }

      context "with no content" do
        it "should return an empty array" do
          main.get_tags(empty_content).should == []
        end
      end

      context "with content" do
        context "url" do
          context "invalid url" do
            let(:opts) { {:url => "invalid url"} }
            it "should return an empty array" do
              main.get_tags(opts).should == []
            end
          end

          context "valid url" do
            let(:opts) { {:url => "www.bbc.co.uk"} }
            it "should return an empty array" do
              main.get_tags(opts).should_not be_empty
            end
          end
        end

        context "content" do
          context "short content" do
            it "should return an empty array" do
              main.get_tags(short_content).should == []
            end
          end

          context "valid content" do
            it "should return an array" do
              main.get_tags(long_content).should_not be_empty
            end
          end

          context "complex content" do
            it "should return an array" do
              main.get_tags(complex_content).should_not be_empty
            end
          end
        end
      end
    end
  end
end
