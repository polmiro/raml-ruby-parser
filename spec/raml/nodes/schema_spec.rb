describe Raml::Nodes::Schema do
  let(:schema) do
    Raml::Nodes::Schema.new(:value => "{ my schema here }")
  end

  it "is valid" do
    expect(schema.valid?).to eq(true)
  end
end