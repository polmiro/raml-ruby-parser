describe Raml::Nodes::MediaType do
  let(:media_type) do
    Raml::Nodes::MediaType.new(:value => "application/json")
  end

  it "is valid" do
    expect(media_type.valid?).to eq(true)
  end
end