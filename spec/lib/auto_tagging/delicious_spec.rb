require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "AutoTagging::Delicious" do
	let(:main) { AutoTagging::Delicious.new }
	
	context "invalid credentials" do
		let(:url) { "www.facebook.com" }

		it "should raise AutoTagging::Errors::InvalidCredentialsError" do
			expect{main.get_tags(url: url)}.to raise_error AutoTagging::Errors::InvalidCredentialsError
		end
	end

	context "valid credentials" do
		let(:valid_credentials) { {"auto_tagging_gem" => "notsecure"} }

		before(:each) { AutoTagging::Delicious.credentials = valid_credentials }

		context "valid options" do
			context "with valid url" do
				let(:url) { "www.facebook.com" }

				it "should return an array" do
					main.get_tags(url: url).should_not be_empty
				end
			end

			context "with invalid url" do
				let(:url) { "www.amustbeinvalidwebsitebb.com"}

				it "should return an empty array" do
					main.get_tags(url: url).should be_empty
				end
			end
		end

		context "invalid options" do
			let(:opt) { "an invalid opt" }

			it "should return an empty array" do
				main.get_tags(opt).should be_empty	
			end
		end
	end	
end