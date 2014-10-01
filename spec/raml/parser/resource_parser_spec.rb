describe Raml::Parser::ResourceParser do
  let(:root) do
    YAML.load <<-YAML
      displayName: Jobs
      type: collection
      description: A collection of jobs
      uriParameters:
        AWSAccessKeyId:
          description: The AWS Access Key ID of the owner of the bucket who grants an Anonymous user access for a request that satisfies the set of constraints in the Policy.
          type: string
        acl:
          description: Specifies an Amazon S3 access control list. If an invalid access control list is specified, an error is generated.
          type: string
      baseUriParameters:
        subapi:
          description: The name of the sub api
          type: string
      get:
        description: Get the collection of jobs
      /{jobId}:
        description: A specific job, a member of the jobs collection
    YAML
  end

  let(:resource) { Raml::Parser::ResourceParser.new("/jobs", root).parse }

  it "parses the name" do
    expect(resource.name).to eq("/jobs")
  end

  it "parses the description" do
    expect(resource.description).to eq("A collection of jobs")
  end

  it "parses the type" do
    expect(resource.type).to eq("collection")
  end

  it "parses the displayName" do
    expect(resource.display_name).to eq("Jobs")
  end

  it "parses the children resources" do
    expect(resource.resources.count).to eq(1)
    expect(resource.resources["/{jobId}"].description).to match("A specific job")
  end

  it "parses the uriParameters" do
    expect(resource.uri_parameters.count).to eq(2)
    expect(resource.uri_parameters["acl"].type).to match("string")
  end

  it "parses the baseUriParameters" do
    expect(resource.base_uri_parameters.count).to eq(1)
    expect(resource.base_uri_parameters["subapi"].description).to eq("The name of the sub api")
  end

  it "parses the methods" do
    expect(resource.get.description).to eq("Get the collection of jobs")
  end

  it "raises parser error when there's an unknown option" do
    resource_parser = Raml::Parser::ResourceParser.new("/jobs", :unknown => true)
    expect { resource_parser.parse }.to raise_error(Raml::ParserError)
  end
end