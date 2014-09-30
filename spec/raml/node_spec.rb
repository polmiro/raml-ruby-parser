describe Raml::Node do
  let(:node) { Raml::Node.new({}) }

  it "response to valid?" do
    expect(node).to respond_to(:valid?)
  end
end