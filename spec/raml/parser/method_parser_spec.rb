describe Raml::Parser::MethodParser do
  let(:root) do
    YAML.load <<-YAML
      description: |
        Get a list of what media is most popular at the moment.
      protocols: [HTTPS]
      queryParameters:
        AWSAccessKeyId:
          description: The AWS Access Key ID of the owner of the bucket who grants an Anonymous user access for a request that satisfies the set of constraints in the Policy.
          type: string
        acl:
          description: Specifies an Amazon S3 access control list. If an invalid access control list is specified, an error is generated.
          type: string
      body:
        schema: |
          {
            "$schema": "http://json-schema.org/draft-03/schema",
            "properties": {
                "input": {
                    "required": false,
                    "type": "string"
                }
            },
            "required": false,
            "type": "object"
          }
      headers:
        X-waiting-period:
          description: |
            The number of seconds to wait before you can attempt to make a request again.
          type: integer
          required: yes
          minimum: 1
          maximum: 3600
          example: 34
      responses:
        200:
          body:
            schema: !include instagram-v1-media-popular.schema.json
        503:
          description: |
            The service is currently unavailable or you exceeded the maximum requests
            per hour allowed to your application.
          body:
            schema: !include instagram-v1-meta-error.schema.json.
    YAML
  end
  let(:method) { Raml::Parser::MethodParser.new("post", root).parse }

  it "parses the type" do
    expect(method.type).to eq("post")
  end

  it "parses the headers" do
    expect(method.headers.count).to eq(1)
    expect(method.headers["X-waiting-period"].description).to match("The number of seconds")
    expect(method.headers["X-waiting-period"].type).to eq("integer")
    expect(method.headers["X-waiting-period"].required).to eq(true)
    expect(method.headers["X-waiting-period"].minimum).to eq(1)
    expect(method.headers["X-waiting-period"].maximum).to eq(3600)
    expect(method.headers["X-waiting-period"].example).to eq("34")
  end

  it "parses the protocols" do
    expect(method.protocols.count).to eq(1)
    expect(method.protocols[0].to_s).to eq("HTTPS")
  end

  it "parses the queryParameters" do
    expect(method.query_parameters.count).to eq(2)
    expect(method.query_parameters["AWSAccessKeyId"].description).to match("The AWS Access Key ID of")
    expect(method.query_parameters["AWSAccessKeyId"].type).to eq("string")
  end

  it "parses the queryParameters" do
    expect(method.protocols.count).to eq(1)
    expect(method.protocols[0].to_s).to eq("HTTPS")
  end

  it "parses the body" do
    expect(method.body.schema.to_s).to match('"type": "object"')
  end

  it "parses the responses" do
    expect(method.responses.count).to eq(2)
    expect(method.responses["200"].body).to be_a(Raml::Body)
    expect(method.responses["503"].description).to match("The service is currently unavailable")
  end

  it "raises parser error when there's an unknown option" do
    method_parser = Raml::Parser::MethodParser.new("get", :unknown => true)
    expect { method_parser.parse }.to raise_error(Raml::ParserError)
  end
end