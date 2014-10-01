describe Raml::Nodes::Document do
  let(:document) do
    Raml::Nodes::Document.new(:title => Raml::Nodes::Title.new(:value => "My API"))
  end

  it "is valid" do
    expect(document.valid?).to eq(true)
  end
end