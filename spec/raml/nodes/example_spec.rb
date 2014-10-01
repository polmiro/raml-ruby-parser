describe Raml::Nodes::Document do
  let(:example) do
    Raml::Nodes::Example.new(:value => "This is my example")
  end

  it "is valid" do
    expect(example.valid?).to eq(true)
  end
end