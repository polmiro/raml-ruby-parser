describe Raml::MultiTypedNamedParameter do

  let(:valid_arguments) do
    [
      "max",
      [
        {
          :name => "name1",
          :type => "string"
        },
        {
          :name => "name2",
          :type => "number"
        },
        {
          :name => "name3",
          :type => "date"
        }
      ],
      Raml::NamedParameter
    ]
  end

  it "is valid" do
    multi_typed = Raml::MultiTypedNamedParameter.new(*valid_arguments)
    expect(multi_typed.valid?).to eq(true)
  end

  it "is not valid when empty" do
    multi_typed = Raml::MultiTypedNamedParameter.new("max", [], Raml::NamedParameter)
    multi_typed.valid?
    expect(multi_typed.errors[:children]).to be_present
  end

end