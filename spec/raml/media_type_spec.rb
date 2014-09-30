describe Raml::MediaType do
  let(:media_type) do
    Raml::MediaType.new(:value => "application/json")
  end

  it "is valid" do
    expect(media_type.valid?).to eq(true)
  end
end