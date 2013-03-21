require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "AutoTagging::OpenCalais" do
  describe "#get_tags" do
    before(:each) { AutoTagging::OpenCalais.api_key = key }
    let(:main) { AutoTagging::OpenCalais.new }

    context "invalid key" do
      let(:key) { 'invalid_key' }

      it "should return an empty array" do
        main.get_tags(long_content).should == []
      end
    end

    context "valid key" do
      let(:key) { "vcpghu34sh4exhrgx6nvetfg" }

      context "with no content" do
        it "should return an empty array" do
          main.get_tags(empty_content).should == []
        end
      end

      context "with content" do
        context "url" do
          let(:opts) { {:url => "http://www.heroku.com" } }
          it "should not raise error" do
            expect { main.get_tags(opts) }.to_not raise_error
          end
        end
        
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
