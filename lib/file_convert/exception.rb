# frozen_string_literal: true
module FileConvert
  module Exception
    class MissingConversionMimeType < StandardError
      def initialize(requested_mime_type, available_mime_types)
        super()
        @requested_mime_type = requested_mime_type
        @available_mime_types = available_mime_types
      end

      def message
        "
          The requested mime type '#{@requested_mime_type}' is not available.
          Available mime types: #{@available_mime_types.join(', ')}.
        "
      end
    end

    class ConnectionError < StandardError
      def initialize(result, action)
        super()
        @result = result
        @error_message = result.error_message
        @action = action
      end

      def message
        "
          An error occured while #{@action}: #{@error_message}.
          Body of request was: #{@result.body}
        "
      end
    end

    class UploadConnectionError < ConnectionError
      def initialize(result)
        super(result, 'uploading')
      end
    end

    class DownloadConnectionError < ConnectionError
      def initialize(result)
        super(result, 'downloading')
      end
    end

    class MissingConfig < StandardError
      def message
        "
          Please define a config for FileConvert.
          See https://github.com/tolingo/file-convert#config for default.
        "
      end
    end
  end
end
