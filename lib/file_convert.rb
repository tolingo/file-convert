module FileConvert
  require 'file_convert/version'
  require 'file_convert/exception'
  require 'file_convert/configure'
  require 'file_convert/client'
  require 'file_convert/file'
  require 'file_convert/upload'
  require 'file_convert/conversion'

  extend Configure and Configure::init_config!

  ###
  # @param [String] file_path
  #   Source file for conversions
  # @param [String]
  #   Source file mime-type
  # @param [String]
  #   Target file mime-type (converion target)
  #
  # @return [FileConvert::Conversion]
  def self.convert(file_path, source_mime_type, target_mime_type)
    upload = FileConvert::Upload.new(client, file_path, source_mime_type)
    FileConvert::Conversion.new(client, upload.file, target_mime_type)
  end

  private

  ###
  # Initialize a new FileConvert::Client
  def self.client
    raise Exception::MissingConfig unless config_present?
    @@client ||= FileConvert::Client.new
  end

end
