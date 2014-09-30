describe Raml::Body do
  let(:body) do
    Raml::Body.new({})
  end

  it "is valid" do
    expect(body.valid?).to eq(true)
  end
end