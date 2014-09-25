describe Raml::Parser do
  describe ".parse" do
    let(:file) { File.expand_path("../../fixtures/large-raml.yml", __FILE__) }
    let(:data) { File.read(file) }

    it "returns the parsed document when succeeds" do
      document = Raml::Parser.parse(data)
      expect(document.class).to eq(Raml::Document)
    end

    it "raises exception when yaml parsing error occurs" do
      expect { Raml::Parser.parse("aaaaaaaaaaa") }.to raise_error(NoMethodError)
    end

    it "raises exception when document parsing errors occurs" do
      allow(Raml::Document).to receive(:new).and_raise(Raml::ParserError)
      expect { Raml::Parser.parse(data) }.to raise_error(Raml::ParserError)
    end
  end
end