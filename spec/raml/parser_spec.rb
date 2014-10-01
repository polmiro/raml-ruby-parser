describe Raml::Parser do
  describe ".parse" do
    let(:file) { File.expand_path("../../fixtures/large-raml.yml", __FILE__) }

    it "returns the parsed document when succeeds" do
      document = Raml::Parser.parse(file)
      expect(document.class).to eq(Raml::Nodes::Document)
    end

    it "raises exception when file not found" do
      expect { Raml::Parser.parse("aaaaaaaaaaa") }.to raise_error(Errno::ENOENT)
    end

    it "raises exception when document parsing errors occurs" do
      allow(Raml::Nodes::Document).to receive(:new).and_raise(Raml::ParserError)
      expect { Raml::Parser.parse(file) }.to raise_error(Raml::ParserError)
    end
  end

  describe "large-raml" do
    let(:file_path) { File.dirname(__FILE__) + "/../fixtures/large-raml.yml" }
    let(:document) { Raml::Parser.parse(file_path) }

    it "sets the title" do
      expect(document.title.to_s).to eq("Box.com API")
    end

    it "sets the version" do
      expect(document.version.to_s).to eq("2.0")
    end

    it "sets the baseUri" do
      expect(document.base_uri.to_s).to eq("https://{apiSubdoamin}.api.box.com/{version}/")
    end

    it "sets the baseUriParameters" do
      expect(document.base_uri_parameters.keys).to eq(["apiSubdomain"])
      apiSubdomainParameter = document.base_uri_parameters["apiSubdomain"]
      expect(apiSubdomainParameter.name).to eq("apiSubdomain")
      expect(apiSubdomainParameter.display_name).to eq("Api subdomain")
      expect(apiSubdomainParameter.description).to eq("The subdomain api")
      expect(apiSubdomainParameter.enum).to eq(["core", "images", "status"])
    end

    it "sets the uriParameters" do
      expect(document.uri_parameters.keys).to eq(["communityPath"])
    end

    it "sets the media_type" do
      expect(document.media_type.to_s).to eq("application/json")
    end

    it "sets the documentation" do
      expect(document.documentation.count).to eq(1)
      expect(document.documentation[0].title).to eq("Home")
      expect(document.documentation[0].content).to match("Welcome to the _Zencoder API_ Documentation")
    end

    it "sets the protocols" do
      expect(document.protocols.length).to eq(2)
      expect(document.protocols[0].to_s).to eq("HTTP")
      expect(document.protocols[1].to_s).to eq("HTTPS")
    end

    it "sets the schemas" do
      expect(document.schemas["Post"].to_s).to eq(File.join(__dir__, "../fixtures/schemas/post.json"))
      expect(document.schemas["Comment"].to_s).to eq(File.join(__dir__, "../fixtures/schemas/comment.json"))
    end

    it "sets the resources" do
      expect(document.resources["/folders"].type).to eq("base")
      expect(document.resources["/folders"].post.description).to match("Used to create")
      expect(document.resources["/folders"].post.body.schema.to_s).to be_present
    end
  end

  describe "local-raml" do
    let(:file_path) { File.dirname(__FILE__) + "/../fixtures/local.yml" }
    let(:document) { Raml::Parser.parse(file_path) }

    it "sets the title" do
      expect(document.title.to_s).to eq("MyApi")
    end

    it "sets the documentation title" do
      expect(document.documentation[0].title.to_s).to eq("Getting Started")
    end

    it "sets the documentation !include content" do
      expect(document.documentation[0].content).to match("This is a getting started guide.")
    end
  end

end