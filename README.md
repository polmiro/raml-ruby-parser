# RAML ruby

Ruby parser for RAML language. Based of the more stable and developed [raml-js-parser](https://github.com/raml-org/raml-js-parser)


<!---
## Installation

Add it to your gemfile:

    gem 'raml-ruby'

Install it:

    $ bundle

Or install it on your ruby environment:

    $ gem install raml-ruby
-->

## Usage

To parse a RAML file:

## TODO of what's left behind

* Multi Typed parameteres are not hooked yet to the document
* Validate non lexic / format
* Validate unexpected property values
* Resource types and traits and apply them (transformations)

```
RamlParser.parse("path/to/your/file.raml")
```
