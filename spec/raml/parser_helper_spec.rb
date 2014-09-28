describe Raml::ParserHelper do

  class ParserHelperClass
    include Raml::ParserHelper
  end

  describe "#safe_array_map" do
    it "returns an empty array when value nil" do
      array = ParserHelperClass.new.safe_array_map("key", nil)
      expect(array).to eq([])
    end

    it "returns the mapped array block when value is an array" do
      array = ParserHelperClass.new.safe_array_map("key", ["house"]) { |v| v.upcase }
      expect(array).to eq(["HOUSE"])
    end

    it "raises a ParserError exception when unknown type" do
      expect do
        ParserHelperClass.new.safe_array_map("key", {})
      end.to raise_error(Raml::ParserError)
    end
  end

  describe "#safe_hash_map" do
    it "returns an empty hash when value nil" do
      hash = ParserHelperClass.new.safe_hash_map("key", nil)
      expect(hash).to eq({})
    end

    it "returns the mapped hash block when value is an hash" do
      hash = ParserHelperClass.new.safe_hash_map("key", { :name => "house" }) do |k, v|
        v.upcase
      end
      expect(hash).to eq({ :name => "HOUSE" })
    end

    it "raises a ParserError exception when unknown type" do
      expect do
        ParserHelperClass.new.safe_hash_map("key", [])
      end.to raise_error(Raml::ParserError)
    end
  end

  describe "#underscore_keys" do
    it "returns the hash with the keys underscored" do
      sample = {:displayName => "houseOfCards", :year => 1922}
      underscoredSample = ParserHelperClass.new.underscore_keys(sample)
      expect(underscoredSample).to eq({ :display_name => "houseOfCards", :year => 1922 })
    end
  end
end