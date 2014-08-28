# File Converter using Google Drive

## Features

* Uses google-api-ruby-client and Google Drive to convert files from one mime-type to another

## Installation

Simply add it to your Gemfile:

```ruby
gem "file-convert"
```

## Config

### Via initializer

`FileConvert` exposes `.configure` which accepts a block and passes the config hash.
*Example*:

```ruby
FileConvert.configure do |config|
  config['google_service_account'] = {
    'email' => '<strange-hash>@developer.gserviceaccount.com',
    'pkcs12_file_path' => 'config/file_convert_key.p12'
  }
end
```

### Via YAML

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

## Available Formats

See [Google Drive API Export Formats](https://developers.google.com/drive/web/integrate-open#open_and_convert_google_docs_in_your_app).

## Examples

```ruby
# converts `path_to_some_file` from <txt> to <pdf>
conversion = FileConvert.convert('path_to_some_file.txt', 'text/plain', 'application/pdf')
# converted body is accessible via `#body`
conversion.body
# .. or define a path to save the converted document to
conversion.save('path_to_new_file.pdf')
```

## Specs

Run `$ bundle exec rspec`

## Next Steps

* Enable OCR if necessary when uploading files
* Add CLI
* Add different adapter than Google?

## Gloss

Copyright © 2014 [Roman Ernst](http://farbenmeer.net), released under MIT license - sponsored by [tolingo GmbH](http://tolingo.com)

.. without warranty of any kind!
