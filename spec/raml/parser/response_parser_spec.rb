describe Raml::Parser::ResponseParser do
  let(:root) do
    YAML.load <<-YAML
      description: "The successful input resource response"
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
        example: |
          {
            "input": "s3://zencodertesting/test.mov"
          }
        formParameters:
          AWSAccessKeyId:
            description: The AWS Access Key ID of the owner of the bucket who grants an Anonymous user access for a request that satisfies the set of constraints in the Policy.
            type: string
          acl:
            description: Specifies an Amazon S3 access control list. If an invalid access control list is specified, an error is generated.
            type: string
          file:
            - type: string
              description: Text content. The text content must be the last field in the form.
            - type: file
              description: File to upload. The file must be the last field in the form.
    YAML
  end

  it "parses the description" do
    response = Raml::Parser::ResponseParser.new(root).parse
    expect(response.description).to match("The successful")
  end

  it "parses the body" do
    response = Raml::Parser::ResponseParser.new(root).parse
    expect(response.body.form_parameters.count).to eq(3)
  end

  it "raises parser error when there's an unknown option" do
    response_parser = Raml::Parser::ResponseParser.new(:unknown => true)
    expect { response_parser.parse }.to raise_error(Raml::ParserError)
  end
end