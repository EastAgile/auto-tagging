require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "AutoTagging::Alchemy" do
  describe "#get_tags" do
    before(:each) { AutoTagging::Alchemy.api_key = key }

    let(:main) { AutoTagging::Alchemy.new }

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
