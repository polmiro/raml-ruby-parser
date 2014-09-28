describe Raml::Document do

  describe "large-raml" do
    let(:file_path) { File.dirname(__FILE__) + "/../fixtures/large-raml.yml" }
    let(:document) { Raml::Document.new(file_path) }

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
      expect(document.documentation[0].content).to eq(<<-TEXT)
Welcome to the _Zencoder API_ Documentation. The _Zencoder API_
allows you to connect your application to our encoding service
and encode videos without going through the web  interface. You
may also benefit from one of our
[integration libraries](https://app.zencoder.com/docs/faq/basics/libraries)
for different languages.
      TEXT
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
  end

  describe "local-raml" do
    let(:file_path) { File.dirname(__FILE__) + "/../fixtures/local.yml" }
    let(:document) { Raml::Document.new(file_path) }

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