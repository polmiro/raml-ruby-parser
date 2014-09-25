describe Raml::NamedParameter do

  let(:valid_attributes) do
    {
      :name => "max",
      :display_name => "Maximum",
      :description => "Maximum value to allow in the query",
      :type => "string",
      :pattern => "/(\d+)/",
      :enum => ["10", "20", '30'],
      :min_length => 2,
      :max_length => 2,
      :example => "10",
      :required => true,
      :repeat => false,
      :default => "30"
    }
  end

  it "is valid" do
    expect(Raml::NamedParameter.new(valid_attributes).valid?).to eq(true)
  end

  it "sets defaults" do
    namedParameter = Raml::NamedParameter.new({:name => "name"})
    expect(namedParameter.type).to eq("string")
    expect(namedParameter.repeat).to eq(false)
    expect(namedParameter.required).to eq(false)
  end

  it "is not valid when type is unknown" do
    attrs = valid_attributes.merge(:type => "unknown")
    namedParameter = Raml::NamedParameter.new(attrs)
    namedParameter.valid?
    expect(namedParameter.errors[:type]).to be_present
  end

  it "is not valid when not string and enum present" do
    attrs = valid_attributes.merge(:type => "number", :enum => ["anything"])
    namedParameter = Raml::NamedParameter.new(attrs)
    namedParameter.valid?
    expect(namedParameter.errors[:enum]).to be_present
  end

  it "is not valid when not string and min_length present" do
    attrs = valid_attributes.merge(:type => "number", :min_length => 1)
    namedParameter = Raml::NamedParameter.new(attrs)
    namedParameter.valid?
    expect(namedParameter.errors[:min_length]).to be_present
  end

  it "is not valid when not string and max_length present" do
    attrs = valid_attributes.merge(:type => "number", :max_length => 10)
    namedParameter = Raml::NamedParameter.new(attrs)
    namedParameter.valid?
    expect(namedParameter.errors[:max_length]).to be_present
  end

  it "is not valid when not number and minimum present" do
    attrs = valid_attributes.merge(:type => "string", :minimum => 10)
    namedParameter = Raml::NamedParameter.new(attrs)
    namedParameter.valid?
    expect(namedParameter.errors[:minimum]).to be_present
  end

  it "is not valid when not number and maximum present" do
    attrs = valid_attributes.merge(:type => "string", :maximum => 10)
    namedParameter = Raml::NamedParameter.new(attrs)
    namedParameter.valid?
    expect(namedParameter.errors[:maximum]).to be_present
  end

end