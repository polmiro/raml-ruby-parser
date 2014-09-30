describe Raml::Schema do
  let(:schema) do
    Raml::Schema.new(:value => "{ my schema here }")
  end

  it "is valid" do
    expect(schema.valid?).to eq(true)
  end
end