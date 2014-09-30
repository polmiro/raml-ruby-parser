describe Raml::Parser::ResourceParser do
  let(:root) do
    YAML.load <<-YAML
    YAML
  end

  it "parses ...." do
    document = Raml::Parser::ResourceParser.new(root).parse
    expect(false).to eq(true)
  end
end