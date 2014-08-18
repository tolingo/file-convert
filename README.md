# File Converter using Google Drive

## Features

* Uses google-api-ruby-client and Google Drive to convert files from one mime-type to another

## Installation

Simply add it to your Gemfile:

```ruby
gem "file-convert"
```

## Config

You need to add a YAML configuration file to `/config/file_convert.yml` that looks like `config/file_convert.sample.yml`.

In order to communicate with the Google API, `file_convert` requires a google developer email Address (`email`) and `pkcs12_file_path`.

Visit [Google Developers Console](console.developers.google.com) and check **Credentials**.
Here you can add a *new Client ID*. Select **Service Account** as application type.

You should now be able to download your *P12 key* and see your *developer email address*.
Place the *P12 key* somewhere accessible for your app and provide the location to the config. The sample config assumes your *P12 key* is located in `/config/file_convert_key.p12`.

Sample config as in `file_convert.samle.yml`:
```yaml
file_convert:
  google_service_account:
    email: '<strange-hash>@developer.gserviceaccount.com'
    pkcs12_file_path: 'config/file_convert_key.p12'
```

## Examples

```ruby
# converts `path_to_some_file` from <txt> to <pdf>
FileConvert.convert('path_to_some_file', 'text/plain', 'application/pdf')
```

## Specs

Run `$ bundle exec rspec -c`

## Next Steps

* Enable OCR if necessary when uploading files
* Add CLI
* Add different adapter than Google?

## Gloss

Copyright © 2013 [Roman Ernst](http://farbenmeer.net), released under CC BY-SA 3.0 license - sponsored by [tolingo GmbH](http://tolingo.com)

.. without warranty of any kind!
