# frozen_string_literal: true
module FileConvert
  class File
    attr_reader :original_file
    attr_reader :data
    attr_reader :conversions

    ##
    # Hold original and conversion
    #
    # @params [File] original_file
    #
    # @return [FileConvert::File]
    def initialize(original_file)
      @original_file = original_file
      @data = original_file.data
      @conversions = {}
    end

    ##
    # Adds a new conversion
    #
    # @param [String] mime_type
    # @param [File] converted_file
    #
    # @return [FileConvert::File] (self)
    def add_conversion(mime_type, converted_file)
      tap { @conversions[mime_type] = converted_file }
    end
  end
end
