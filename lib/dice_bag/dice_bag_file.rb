require 'dice_bag/version'

# This module contains common methods for all the type of files Dicebag knows about:
# configuration files, templates files in the project an templates files shipped with dicebag
module DiceBag
  module DiceBagFile
    attr_reader :file, :filename

    def assert_existence
      unless File.exists?(@file)
        raise "File #{@filename} not found. Configuration file not created"
      end
    end

    def write(contents)
      File.open(@file, 'w') do |file| 
        file.puts(file_announcement) unless contents.include?("dice_bag")
        file.puts(contents)
      end 
    end
    
    def file_announcement
     <<-DESC
       # This file was automatically generated by dice_bag #{VERSION}.
       # You should not modify this file directly.
       # If this file does not fulfill your needs, raise an issue on the dice_bag github
       # repository or create a local template, read the dice_bag README for details.
     DESC
    end

  end 
end
