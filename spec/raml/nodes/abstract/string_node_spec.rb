describe Raml::Nodes::StringNode do
  let(:api_version) { Raml::Nodes::StringNode.new(:value => "v1") }

  it "is valid" do
    expect(api_version.valid?).to eq(true)
  end

  describe "#to_s" do
    it "prints the value" do
      expect(api_version.to_s).to eq("v1")
    end
  end
end