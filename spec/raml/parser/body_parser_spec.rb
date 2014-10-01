describe Raml::Parser::BodyParser do
  let(:root) do
    YAML.load <<-YAML
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

  it "parses the formParameters" do
    body = Raml::Parser::BodyParser.new(root).parse
    expect(body.form_parameters.count).to eq(3)
    expect(body.form_parameters["AWSAccessKeyId"].description).to match("The AWS Access Key ID of")
    expect(body.form_parameters["AWSAccessKeyId"].type).to eq("string")
  end

  it "parses the example" do
    body = Raml::Parser::BodyParser.new(root).parse
    expect(body.example.to_s).to match("s3://zencodertesting/test.mov")
  end

  it "parses the schema" do
    body = Raml::Parser::BodyParser.new(root).parse
    expect(body.schema.to_s).to match('"type": "object"')
  end

  it "raises parser error when there's an unknown option" do
    body_parser = Raml::Parser::BodyParser.new(:unknown => true)
    expect { body_parser.parse }.to raise_error(Raml::ParserError)
  end
end