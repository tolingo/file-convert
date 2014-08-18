module FileConvert
  module Exception

    class MissingConversionMimeType < StandardError
      def initialize(requested_mime_type, available_mime_types)
        super()
        @requested_mime_type = requested_mime_type
        @available_mime_types = available_mime_types
      end

      def message
        """
          The requested mime type '#{@requested_mime_type}' is not available.
          Available mime types: #{@available_mime_types.join(', ')}.
        """
      end
    end

    class DownloadConnectionError < StandardError
      def initialize(error_message)
        super()
        @error_message = error_message
      end

      def message
        """
          An error occured connection to Google Drive.
          Error message was: #{@error_message}
        """
      end
    end

  end
end
