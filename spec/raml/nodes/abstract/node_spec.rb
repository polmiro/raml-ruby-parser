describe Raml::Nodes::Node do
  let(:node) { Raml::Nodes::Node.new({}) }

  it "response to valid?" do
    expect(node).to respond_to(:valid?)
  end
end