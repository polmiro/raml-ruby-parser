describe Raml::Nodes::Response do
  let(:response) do
    Raml::Nodes::Response.new(:description => "The mentioned resource", :body => Raml::Nodes::Body.new({}))
  end

  it "is valid" do
    expect(response.valid?).to eq(true)
  end
end