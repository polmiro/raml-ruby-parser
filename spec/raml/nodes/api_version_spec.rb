describe Raml::Nodes::ApiVersion do
  let(:api_version) do
    Raml::Nodes::ApiVersion.new(:value => "V3")
  end

  it "is valid" do
    expect(api_version.valid?).to eq(true)
  end
end