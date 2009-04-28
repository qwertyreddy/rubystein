require 'rubygems'
require 'gosu'

SOUND_TO_TEXT = {
  'mein_spagetthicode.wav'  => 'My spaghetti code!',
  'meine_magischen_qpc.wav' => 'My magic quotes!',
  'meine_sql.wav'   => 'My SQL injections!',
  'balloon.mp3'     => "Don't you want a... balloon?",
  'dog_bark.mp3'    => 'Bark!',
  'dog_cry.mp3'     => ':-(',
  'floating.mp3'    => 'They are all FLOATING!',
  'fuck_you.mp3'    => '\"Fuck you!\"',
}

class SoundPool
  @@sounds = {}
  
  def self.get(window, file_name)
    if @@sounds[file_name].nil?
      @@sounds[file_name] = Gosu::Sample.new(window, file_name)
    end
    
    return @@sounds[file_name]
  end
end