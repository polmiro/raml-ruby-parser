describe Raml::Resource do
  let(:attrs) do
    {
      :name => "/posts",
      :type => "base",
      :description => "My blog posts",
      :protocols => [Raml::Protocol.new(:value => "HTTP")],
      :uri_parameters => { 'id' => Raml::UriParameter.new(:name => 'id') },
      :base_uri_parameters => { "subapi" => Raml::BaseUriParameter.new(:name => 'subapi') },
      :resources => { "/comments" => Raml::Resource.new(:name => "/comments") },
      :get => Raml::Method.new(:type => "get"),
      :post => Raml::Method.new(:type => "post"),
      :put => Raml::Method.new(:type => "put"),
      :patch => Raml::Method.new(:type => "patch")
    }
  end

  it "is valid" do
    resource = Raml::Resource.new(attrs)
    expect(resource.valid?).to eq(true)
  end

  it "assigns the name as display_name when there is no display_name" do
    resource = Raml::Resource.new(attrs)
    expect(resource.display_name).to eq("/posts")
  end

  it "assigns the display_name when present" do
    resource = Raml::Resource.new(attrs.merge(:display_name => "My custom display_name"))
    expect(resource.display_name).to eq("My custom display_name")
  end
end