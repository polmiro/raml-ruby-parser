describe Raml::Parser::ParserHelper do

  class ParserHelperClass
    include Raml::Parser::ParserHelper
  end

  let(:helper) { ParserHelperClass.new }

  describe "#set_yaml_include_path" do
  end

  describe "#parse_parameters" do
    let(:yaml) do
      <<-YAML
      communityDomain:
        displayName: Community Domain
        type: string
      communityPath:
        displayName: Community Path
        type: string
        pattern: ^[a-zA-Z0-9][-a-zA-Z0-9]*$
        minLength: 1
     YAML
    end

    it "parses an array if uri parameters" do
      parameters = helper.parse_parameters("uriParameters", Raml::UriParameter, YAML.load(yaml))
      expect(parameters["communityDomain"]).to be_a(Raml::UriParameter)
      expect(parameters["communityDomain"].display_name).to eq("Community Domain")
      expect(parameters["communityDomain"].type).to eq("string")
      expect(parameters["communityPath"]).to be_a(Raml::UriParameter)
      expect(parameters["communityPath"].display_name).to eq("Community Path")
      expect(parameters["communityPath"].type).to eq("string")
      expect(parameters["communityPath"].pattern).to eq("^[a-zA-Z0-9][-a-zA-Z0-9]*$")
      expect(parameters["communityPath"].min_length).to eq(1)
    end
  end

  describe "#parse_responses" do
    let(:response_hash) do
      { "200" => { "description" => "The successful input resource response" } }
    end

    it "raises ParserError when unexpected type" do
      expect { helper.parse_responses("hello") }.to raise_error(Raml::ParserError)
    end

    it "parsers the responses" do
      responses = helper.parse_responses(response_hash)
      expect(responses["200"]).to be_a(Raml::Response)
      expect(responses["200"].description).to match("The successful")
    end
  end

  describe "#safe_array_map" do
    it "returns an empty array when value nil" do
      array = helper.safe_array_map("key", nil)
      expect(array).to eq([])
    end

    it "returns the mapped array block when value is an array" do
      array = helper.safe_array_map("key", ["house"]) { |v| v.upcase }
      expect(array).to eq(["HOUSE"])
    end

    it "raises a ParserError exception when unknown type" do
      expect do
        helper.safe_array_map("key", {})
      end.to raise_error(Raml::ParserError)
    end
  end

  describe "#safe_hash_map" do
    it "returns an empty hash when value nil" do
      hash = helper.safe_hash_map("key", nil)
      expect(hash).to eq({})
    end

    it "returns the mapped hash block when value is an hash" do
      hash = helper.safe_hash_map("key", { :name => "house" }) do |k, v|
        v.upcase
      end
      expect(hash).to eq({ :name => "HOUSE" })
    end

    it "raises a ParserError exception when unknown type" do
      expect do
        helper.safe_hash_map("key", [])
      end.to raise_error(Raml::ParserError)
    end
  end

  describe "#underscore_keys" do
    it "returns the hash with the keys underscored" do
      sample = {:displayName => "houseOfCards", :year => 1922}
      underscoredSample = helper.underscore_keys(sample)
      expect(underscoredSample).to eq({ :display_name => "houseOfCards", :year => 1922 })
    end
  end
end