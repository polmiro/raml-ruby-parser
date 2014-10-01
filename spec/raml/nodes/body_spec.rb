describe Raml::Nodes::Body do
  let(:body) do
    Raml::Nodes::Body.new({})
  end

  it "is valid" do
    expect(body.valid?).to eq(true)
  end
end