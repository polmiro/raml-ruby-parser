describe Raml::Nodes::Method do
  let(:attrs) do
    { type: "get" }
  end

  it "is valid" do
    method = Raml::Nodes::Method.new(attrs)
    expect(method.valid?).to eq(true)
  end

  it "is not valid with an invalid type" do
    method = Raml::Nodes::Method.new(attrs.merge(:type => "invalid"))
    expect(method.valid?).to eq(false)
  end

  it "is valid when responses have valid http status" do
    attrs.merge!(
      :responses => {
        "200" => Raml::Nodes::Response.new({}),
        "*/*" => Raml::Nodes::Response.new({})
      }
    )
    method = Raml::Nodes::Method.new(attrs)
    expect(method.valid?).to eq(true)
  end

  it "is not valid when responses have non integer http status" do
    attrs.merge!(
      :responses => {
        "invalid" => Raml::Nodes::Response.new({})
      }
    )
    method = Raml::Nodes::Method.new(attrs)
    expect(method.valid?).to eq(false)
  end

  it "is not valid when responses have */* before other statuses" do
    attrs.merge!(
      :responses => {
        "*/*" => Raml::Nodes::Response.new({}),
        "200" => Raml::Nodes::Response.new({})
      }
    )
    method = Raml::Nodes::Method.new(attrs)
    expect(method.valid?).to eq(false)
  end
end