describe Raml::Nodes::Protocol do
  it "is valid" do
    expect(Raml::Nodes::Protocol.new(:value => "HTTP").valid?).to eq(true)
  end

  it "is not valid without an accepted protocol" do
    expect(Raml::Nodes::Protocol.new(:value => "FTP").valid?).to eq(false)
  end
end