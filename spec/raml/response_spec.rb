describe Raml::Response do
  let(:response) do
    Raml::Response.new(:description => "The mentioned resource", :body => Raml::Body.new({}))
  end

  it "is valid" do
    expect(response.valid?).to eq(true)
  end
end