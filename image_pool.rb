require 'rubygems'
require 'gosu'

class ImagePool
  @@image_files = {}
  @@image_texts = {}
  
  def self.get_file(window, filename)
    if !@@image_files.has_key?(filename)
      @@image_files[filename] = Gosu::Image.new(window, filename)
    end
    @@image_files[filename]
  end
  
  def self.get_text(window, text)
    if !@@image_texts.has_key?(text)
      lines = text.split("\n")
      @@image_texts[text] = lines.map do |line|
        Gosu::Image.from_text(window, line, "Arial", 24)
      end
    end
    @@image_texts[text]
  end
end