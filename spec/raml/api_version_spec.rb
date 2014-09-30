describe Raml::ApiVersion do
  let(:api_version) do
    Raml::ApiVersion.new(:value => "V3")
  end

  it "is valid" do
    expect(api_version.valid?).to eq(true)
  end
end