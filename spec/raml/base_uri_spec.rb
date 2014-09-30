describe Raml::BaseUri do
  let(:base_uri) do
    Raml::BaseUri.new(:value => "http://api.example.com")
  end

  it "is valid" do
    expect(base_uri.valid?).to eq(true)
  end
end