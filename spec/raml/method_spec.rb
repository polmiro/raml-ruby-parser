describe Raml::Method do
  let(:attrs) do
    { type: "get" }
  end

  it "is valid" do
    method = Raml::Method.new(attrs)
    expect(method.valid?).to eq(true)
  end

  it "is not valid with an invalid type" do
    method = Raml::Method.new(attrs.merge(:type => "invalid"))
    expect(method.valid?).to eq(false)
  end

  it "is valid when responses have valid http status" do
    attrs.merge!(
      :responses => {
        "200" => Raml::Response.new({}),
        "*/*" => Raml::Response.new({})
      }
    )
    method = Raml::Method.new(attrs)
    expect(method.valid?).to eq(true)
  end

  it "is not valid when responses have non integer http status" do
    attrs.merge!(
      :responses => {
        "invalid" => Raml::Response.new({})
      }
    )
    method = Raml::Method.new(attrs)
    expect(method.valid?).to eq(false)
  end

  it "is not valid when responses have */* before other statuses" do
    attrs.merge!(
      :responses => {
        "*/*" => Raml::Response.new({}),
        "200" => Raml::Response.new({})
      }
    )
    method = Raml::Method.new(attrs)
    expect(method.valid?).to eq(false)
  end
end