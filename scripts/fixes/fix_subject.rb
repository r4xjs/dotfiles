#!/usr/bin/ruby
require 'shellwords'
require 'tempfile'
require 'fileutils'

email=Shellwords.escape(ARGV[0])
subject=`gpg -dq '#{email}' | grep "Subject:" | head -1`
if subject.length != 0
  found = false
  Tempfile.open('temp_email_', '/tmp') do |tmp|
      File.open(email, 'r').each do |line|
          if(!found && line =~ /^Subject:/)
              tmp.write("#{subject}")
              found = true
              next
          end
          tmp.write(line)
      end
      tmp.flush()
      FileUtils.cp(tmp.path, email)
  end
end
