# file-convert [![Build Status](https://travis-ci.org/tolingo/file-convert.svg?branch=feature%2Ffix-specs-and-refactor)](https://travis-ci.org/tolingo/file-convert) [![Code Climate](https://codeclimate.com/repos/53f4984b6956807963019c1a/badges/7aef33ebfd86eb320a98/gpa.svg)](https://codeclimate.com/repos/53f4984b6956807963019c1a/feed) [![Dependency Status](https://gemnasium.com/tolingo/file-convert.svg)](https://gemnasium.com/tolingo/file-convert)

> Use google-api-ruby-client and Google Drive to convert files from one mime-type to another.
For available formats see [Google Drive API Export Formats](https://developers.google.com/drive/web/integrate-open#open_and_convert_google_docs_in_your_app).

## Installation

Simply add it to your Gemfile:

```ruby
gem 'file-convert'
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

* `$ bundle exec rake` for `rspec` and `rubocop`.
* `$ bundle exec rake build` to also run the `integration` tests located at `spec/integration/**/*_integration.rb`.
Note that you need to have a valid `config/file_convert.yml` present for these tests to work,
since we want to actually test the integration with the Google API here. (Do not worry, TravisCI will run these test as well.)

## Contributing

In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Lint and test your code using the ways described [above](#specs).

## Next Steps

* Enable OCR if necessary when uploading files
* Add CLI
* Add different adapter than Google?

## License
file-convert is Copyright © 2014 [Roman Ernst](http://farbenmeer.net) and [tolingo GmbH](http://tolingo.com) and may be redistributed under the terms specified in the [LICENSE](https://github.com/tolingo/file-convert/blob/master/LICENSE) file.
