require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "AutoTagging::Yahoo::Main" do
  describe "#get_tags" do
    let(:main) { AutoTagging::Yahoo::Main.new }

    context "empty content" do
      it "should return empty array" do
        main.get_tags(empty_content).should == []
      end
    end

    context "not empty content" do
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
