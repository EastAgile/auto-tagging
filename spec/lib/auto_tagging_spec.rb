require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "AutoTagging" do
  describe "services=" do
    let(:services) { ["yahoo", {"open_calais" => "key"}] }
    it "should call add_service for each service" do
      services.each {|service| AutoTagging.should_receive(:add_service).with(service)}
      AutoTagging.services = services
    end
  end

  describe "#const" do
    let(:service) { {"open_calais" => "jqk145" } }

    before(:each) { AutoTagging.should_receive(:service_name).with(service).and_return(service_name) }

    context "valid service" do
      let(:service_name) { "open_calais" }

      it "should return valid class" do
        AutoTagging.send(:const, service).should == AutoTagging::OpenCalais
      end
    end

    context "invalid service name" do
      let(:service_name) { "google" }

      it "should raise AutoTagging::Errors::InvalidServiceError" do
        expect do
          AutoTagging.send(:const, service)
        end.to raise_error(AutoTagging::Errors::InvalidServiceError)
      end
    end
  end

  describe "#add_service" do
    let(:service) { "yahoo" }
    let(:klass) { double(:const, :new => "") }
    before(:each) { AutoTagging.stub(:const).and_return(klass) }

    it "should invoke const on given service" do
      AutoTagging.should_receive(:const).with(service)
      AutoTagging.send(:add_service,service)
    end

    it "should add obj to mains" do
      expect do
        AutoTagging.send(:add_service,service)
      end.to change(AutoTagging.mains,:size).by(1)
    end
  end

  describe "#get_tags" do
    context "without main objs" do
      before(:each) { AutoTagging.reset_mains }
      it "should raise AutoTagging::Errors::NoServiceConfigurationError" do
        expect do
          AutoTagging.get_tags(short_content)
        end.to raise_error(AutoTagging::Errors::NoServiceConfigurationError)
      end
    end

    context "with main objs" do
      let(:yahoo_main) { AutoTagging::Yahoo.new }
      let(:alchemy_main) { AutoTagging::Alchemy.new }
      let(:open_calais_main) { AutoTagging::OpenCalais.new }
      let(:mains) { [yahoo_main, alchemy_main, open_calais_main] }

      before(:each) do
        AutoTagging.stub(:mains).and_return(mains)
      end

      it "should invoke get_tags for each main obj" do
        mains.each { |main| main.should_receive(:get_tags).with(long_content) }
        AutoTagging.get_tags(long_content)
      end
    end
  end
end
