require 'rubygems'
require 'gosu'

SOUND_TO_TEXT = {
  'mein_spagetthicode.wav'  => 'My spaghetti code!',
  'meine_magischen_qpc.wav' => 'My magic quotes!',
  'meine_sql.wav'   => 'My SQL injections!',
  'balloon.mp3'     => "Don't you want a... balloon?",
  'dog_bark.mp3'    => 'Woof! :-)',
  'dog_cry.mp3'     => ':-D',
  'floating.mp3'    => 'They are all FLOATING!',
  'test_all_the_effing_time_is_lame.mp3' => "'Test all the fucking time' is lame.",
  'long live php.mp3'    => 'Long live PHP!',
  'my damn php life.mp3' => 'My damn PHP life!',
  'myphplife.mp3'        => 'My life for PHP!',
  'phpforever.mp3'       => 'PHP forever!',
  'omgponies.mp3'        => 'OMG PONIES!!!11 :-D',
  'too_many_io_errors.ogg' => 'Too many I/O errors!',
  'long_live_http.ogg'     => 'Long live HTTP!',
  'connection_broken.ogg'  => 'Connection broken!',
  'i_hope_you_catch_swine_flu.ogg' => 'I hope you catch swine flu!',
  'i_will_not_be_defeated.ogg'     => 'I will not be defeated by you!',
  'your_attack_is_weak.ogg'        => 'Your attack is weak!',
  'impossible.ogg'                 => 'I... impossible!',
  'ni.ogg'                         => 'Ni !!! Ni !!!',
  'never_gonna_give_you_up.ogg'    => 'Never gonna give you up!',
  'nooo.ogg'                       => 'NOOHHHhurrghhhaaaahhh ... urrghhah',
  'boom_headshot.ogg'              => 'BOOM ! HEADSHOT!'
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