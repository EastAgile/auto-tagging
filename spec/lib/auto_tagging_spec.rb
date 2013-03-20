require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "AutoTagging::Main" do
  describe "services=" do
    let(:services) { ["yahoo", {"open_calais" => "key"}] }
    it "should call add_service for each service" do
      services.each {|service| AutoTagging::Main.should_receive(:add_service).with(service)}
      AutoTagging::Main.services = services
    end

    context "add_service raise error" do
      before(:each) { AutoTagging::Main.stub(:add_service).and_raise(StandardError) }

      it "should raise AutoTagging::Errors::InvalidServiceError" do
        expect do
          AutoTagging::Main.services = services
        end.to raise_error(AutoTagging::Errors::InvalidServiceError)
      end
    end
  end

  describe "add_service" do
    after(:each) { AutoTagging::Main.reset_mains }
    context "string param" do
      context "with invalid service" do
        let(:invalid_service) { "google" }

        it "should raise NameError" do
          expect { AutoTagging::Main.send(:add_service,invalid_service)}.to raise_error(NameError)
        end
      end

      context "with valid service" do
        let(:invalid_service) { "yahoo" }
        before(:each) { AutoTagging::Main.send(:add_service,invalid_service) }

        it "should init main obj for each service" do
          AutoTagging::Main.mains.size.should == 1
          AutoTagging::Main.mains[0].should be_instance_of AutoTagging::Yahoo::Main
        end
      end
    end

    context "hash param" do
      context "with invalid service" do
        let(:invalid_service) { { :google => "api_key" }}

        it "should raise NameError" do
          expect { AutoTagging::Main.send(:add_service,invalid_service)}.to raise_error(NameError)
        end
      end

      context "with valid service" do
        before(:each) { AutoTagging::Main.send(:add_service,valid_service) }
        let(:key) { "api_key" }
        let(:valid_service) { { :open_calais => key }}

        it "should init main obj for each service" do
          AutoTagging::Main.mains.size.should == 1
          AutoTagging::Main.mains[0].should be_instance_of AutoTagging::OpenCalais::Main
        end

        it "should set api key the main obj of given service" do
          AutoTagging::OpenCalais::Main.api_key.should == key
        end
      end
    end
  end

  describe "#get_tags" do
    context "without main objs" do
      before(:each) { AutoTagging::Main.reset_mains }
      it "should raise AutoTagging::Errors::NoServiceConfigurationError" do
        expect do
          AutoTagging::Main.get_tags(short_content)
        end.to raise_error(AutoTagging::Errors::NoServiceConfigurationError)
      end
    end

    context "with main objs" do
      let(:yahoo_main) { AutoTagging::Yahoo::Main.new }
      let(:alchemy_main) { AutoTagging::Alchemy::Main.new }
      let(:open_calais_main) { AutoTagging::Alchemy::Main.new }
      let(:mains) { [yahoo_main, alchemy_main, open_calais_main] }

      before(:each) do
        AutoTagging::Main.stub(:mains).and_return(mains)
      end

      it "should invoke get_tags for each main obj" do
        mains.each { |main| main.should_receive(:get_tags).with(long_content) }
        AutoTagging::Main.get_tags(long_content)
      end
    end
  end
end
