describe Raml::Documentation do
  let(:documentation) do
    Raml::Documentation.new(:title => "Github docs", :content => "http://github.com")
  end

  it "is valid" do
    expect(documentation.valid?).to eq(true)
  end
end