require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "AutoTagging" do
  describe "Main" do
    let(:valid_key) { 'vcpghu34sh4exhrgx6nvetfg' }
    let(:invalid_key) { 'invalid_key' }
    let(:service) { 'open_calais' }

    describe "#initialize" do
      context "invalid service" do
        let(:invalid_service) { 'service' }
        it "should raise AutoTagging::Errors::InvalidServiceError" do
          expect do
            AutoTagging::Main.new(invalid_service, valid_key)
          end.to raise_error(AutoTagging::Errors::InvalidServiceError)
        end
      end

      context "valid service" do
        it "should create a new Main obj" do
          AutoTagging::Main.new(service, valid_key).should be_instance_of AutoTagging::Main
        end
      end
    end
  end
end
