module FileConvert
  module Exception
    class MissingConversionMimeType < StandardError
      def initialize(requested_mime_type, available_mime_types)
        super()
        @requested_mime_type = requested_mime_type
        @available_mime_types = available_mime_types
      end

      def message
        ''"
          The requested mime type '#{@requested_mime_type}' is not available.
          Available mime types: #{@available_mime_types.join(', ')}.
        "''
      end
    end

    class UploadedFileDataError < StandardError
      def initialize(upload_result)
        super()
        @upload_result = upload_result
      end

      def message
        ''"
          An error occured while uploading: #{@upload_result.error_message}.
        "''
      end
    end

    class DownloadConnectionError < StandardError
      def initialize(result)
        super()
        @result = result
      end

      def message
        ''"
          An error occured connection to Google Drive.
          Result of request was: #{@result}
        "''
      end
    end

    class MissingConfig < StandardError
      def message
        ''"
          Please define a config for FileConvert.
          See https://github.com/tolingo/file-convert#config for default.
        "''
      end
    end
  end
end
