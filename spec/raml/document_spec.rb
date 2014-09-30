describe Raml::Document do
  let(:document) do
    Raml::Document.new(:title => Raml::Title.new(:value => "My API"))
  end

  it "is valid" do
    expect(document.valid?).to eq(true)
  end
end