describe Raml::Nodes::Title do
  let(:title) do
    Raml::Nodes::Title.new(:value => "My awesome API")
  end

  it "is valid" do
    expect(title.valid?).to eq(true)
  end
end