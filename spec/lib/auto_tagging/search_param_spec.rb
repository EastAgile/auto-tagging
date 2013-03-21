require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "AutoTagging::SearchParam" do
  describe "#url_search?" do
    let(:key) { "e0d4cf69ba90640704a9f831b69b6ec7531142fe" }

    context "invalid search options" do
      let(:opts) { {:website => "http://www.yahoo.com"} }

      it "should raise AutoTagging::Errors::InvalidSearchError" do
        expect do
          AutoTagging::SearchParam.url_search?(opts)
        end.to raise_error(AutoTagging::Errors::InvalidSearchError)
      end
    end

    context "valid search options" do
      context "url search" do
        let(:opts) { {:url => "http://www.yahoo.com"} }

        it "should return true" do
          AutoTagging::SearchParam.url_search?(opts).should be_true
        end
      end

      context "text search" do
        let(:opts) { "just a normal text search" }

        it "should return false" do
          AutoTagging::SearchParam.url_search?(opts).should be_false
        end
      end
    end
  end
end
