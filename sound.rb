require 'rubygems'
require 'gosu'

SOUND_TO_TEXT = {
  'mein_spagetthicode.ogg'  => 'My spaghetti code!',
  'meine_magischen_qpc.ogg' => 'My magic quotes!',
  'meine_sql.ogg'   => 'My SQL injections!',
  'balloon.ogg'     => "Don't you want a... balloon?",
  'dog_bark.ogg'    => 'Bark!',
  'dog_cry.ogg'     => ':-(',
  'floating.ogg'    => 'They are all FLOATING!',
  'test_all_the_effing_time_is_lame.ogg' => "'Test all the fucking time' is lame.",
  'long live php.ogg'    => 'Long live PHP!',
  'my damn php life.ogg' => 'My damn PHP life!',
  'myphplife.ogg'        => 'My life for PHP!',
  'phpforever.ogg'       => 'PHP forever!',
  'omgponies.ogg'        => 'OMG PONIES!!!11 :-D',
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
