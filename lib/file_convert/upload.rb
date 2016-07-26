# frozen_string_literal: true
module FileConvert
  class Upload
    DEFAULT_PARAMS = {
      'uploadType' => 'multipart',
      'convert' => true,
      'alt' => 'json'
    }.freeze

    attr_reader :file

    ##
    # Uploads file to Google Drive
    #
    # @param [FileConvert::Client] client
    # @param [String] file_path
    #   File to upload
    # @param [String] mime_type
    #   Source mime_type of upload-file
    #
    # @return [FileConvert::File] New File object without conversions yet
    def initialize(client, file_path, mime_type)
      @client = client
      @file_path = file_path
      @mime_type = mime_type

      uploaded_file = client.execute(
        api_method: client.drive.files.insert,
        body_object: touch_file,
        media: upload_io,
        parameters: DEFAULT_PARAMS
      )

      @file = FileConvert::File.new(uploaded_file)
    end

    private

    def touch_file
      @client.drive.files.insert.request_schema.new(
        'title' => SecureRandom.uuid,
        'description' => 'FileConvert Conversion-File',
        'mimeType' => @mime_type
      )
    end

    def upload_io
      Google::APIClient::UploadIO.new(@file_path, @mime_type)
    end
  end
end
