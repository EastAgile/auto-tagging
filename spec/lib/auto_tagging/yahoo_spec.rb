require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "AutoTagging" do
  describe "Yahoo" do
    describe "Main" do
      describe "#get_tags" do
        let(:main) { AutoTagging::Yahoo::Main.new }

        context "empty content" do
          let(:content) { '' }

          it "should return empty array" do
            main.get_tags(content).should == []
          end
        end

        context "not empty content" do
          let(:content) do
            %{ In the UK, the HPA has recorded eight cases of oseltamivir-resistant H1N1pdm09 in the community setting.
The HPA's head of flu surveillance Dr Richard Pebody said: "While the frequency of oseltamivir resistance in community settings has increased slightly since the 2009-10 pandemic from 1-2% in the 2012/13 flu season, rates of detection remain low."
Swine flu (H1N1) infected a fifth of people during the first year of the pandemic in 2009, data suggest.
It is thought the virus killed 200,000 people globally.
Although the pandemic has been declared by officials as over, the virus is still circulating.
During the pandemic, the H1N1 virus crowded out other influenza viruses to become the dominant virus. This is no longer the case. Many countries are reporting a mix of influenza viruses. }
          end

          it "should return an array" do
            main.get_tags(content).should_not be_empty
          end
        end

        context "complex content" do
          let(:content) do
            %{ I have a dream, a song to sing !@$%^&*(_)+~':":{}
              "(%&*$(7#)*$ Manchester United }
          end

          it "should return an array" do
            main.get_tags(content).should_not be_empty
          end
        end
      end
    end
  end
end
