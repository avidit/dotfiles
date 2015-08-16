#!/usr/bin/ruby

require 'irb'
require 'irb/completion'
require 'irb/ext/save-history'
require 'awesome_print'
AwesomePrint.irb!

%w[rubygems wirble].each do |gem|
  begin
    require gem
  rescue LoadError
    puts "#{gem} was not found"
  end
end

# IRB history
ARGV.concat %w(--readline --prompt-mode simple)
IRB.conf[:EVAL_HISTORY] = 1000
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = '~/.irb_history'

# configure IRB
IRB.conf[:PROMPT][:CUSTOM] = {
  :PROMPT_I => '>> ',
  :PROMPT_S => '%l>> ',
  :PROMPT_C => '.. ',
  :PROMPT_N => '.. ',
  :RETURN => "=> %s\n"
}
IRB.conf[:PROMPT_MODE] = :CUSTOM
IRB.conf[:AUTO_INDENT] = true

alias e exit