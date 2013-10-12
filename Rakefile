#!/usr/bin/env rake

desc "Runs strainer test"
task :strainertest do
  sandbox = File.join(File.dirname(__FILE__), %w{tmp strainer cookbook})
  files = %w{*.md *.rb attributes definitions files libraries provider recipes resources templates}

  rm_rf sandbox
  mkdir_p sandbox
  cp_r Dir.glob("{#{files.join(',')}}"), sandbox
  puts "\n\n"
  sh "bundle exec strainer test #{sandbox}"
end

task :default => 'strainertest'
