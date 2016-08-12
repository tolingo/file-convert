# frozen_string_literal: true
module FileConvert
  class Conversion
    attr_reader :file
    attr_reader :body

    ##
    # Downloads remote file from Google Drive with given mime_type
    #
    # @param [FileConvert::Client] client
    # @param [FileConvert::File] remote_file
    # @param [String] mime_type
    #   Target mime_type the file gets converted to
    #
    # @return [FileConvert::File] remote_file with requested #conversions
    def initialize(client, remote_file, mime_type)
      @client = client
      @remote_file = remote_file
      @original_upload_result = remote_file.original_file
      @remote_file_data = remote_file.data
      @mime_type = mime_type

      # Fail if upload errored
      raise data_error_exception if @original_upload_result.error?
      # Fail if requested mime-type is not available
      raise missing_mime_type_exception unless export_links.key?(mime_type)

      @file = fetch_file
      @body = @file.body
      @remote_file.add_conversion(mime_type, self)
    end

    ##
    # Saves result as file
    # @param [String] target_path
    #
    # @return [FileConvert::Conversion]
    def save(target_path)
      ::File.open(target_path, 'wb') { |file| file.write(@file.body) }
    end

    private

    ##
    # @return [Hash] available mime-type download URIs
    def export_links
      available_links = @remote_file_data['exportLinks'] || {}
      available_links.to_hash
    end

    ##
    # Actually downloads the file
    # Raises if request was not successfull
    #
    # @return [Google::APIClient::Result]
    def fetch_file
      @client.execute(uri: export_links[@mime_type]).tap do |result|
        raise connection_error_exception(result) unless result.success?
      end
    end

    def data_error_exception
      Exception::UploadConnectionError.new @original_upload_result
    end

    def missing_mime_type_exception
      Exception::MissingConversionMimeType.new @mime_type, export_links.keys
    end

    def connection_error_exception(result)
      Exception::DownloadConnectionError.new result
    end
  end
end
