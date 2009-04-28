verbose true

PACKAGE_NAME = "rubystein"
PACKAGE_VERSION = "1.0"

task :package do
  sh "rm -rf #{PACKAGE_NAME}-#{PACKAGE_VERSION}"
  sh "mkdir -p #{PACKAGE_NAME}-#{PACKAGE_VERSION}"
  sh "cp -pR CREDIT *.rb *.mp3 *.wav *.ogg *.png *.bmp #{PACKAGE_NAME}-#{PACKAGE_VERSION}/"
  sh "tar -zcf #{PACKAGE_NAME}-#{PACKAGE_VERSION}.tar.gz #{PACKAGE_NAME}-#{PACKAGE_VERSION}"
end
