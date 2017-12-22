#!/usr/bin/ruby

%w[rubygems irb irb/completion irb/ext/save-history awesome_print].each do |gem|
  begin
    require gem
  rescue LoadError => err
    warn "could not load #{gem}: #{err}"
  end
end

AwesomePrint.irb! if defined? AwesomePrint

# IRB history
ARGV.concat %w(--readline --prompt-mode simple)
IRB.conf[:EVAL_HISTORY] = 1000
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-history"

# configure IRB
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:PROMPT_MODE] = :CUSTOM
IRB.conf[:PROMPT][:CUSTOM] = {
  :PROMPT_I => '>> ',
  :PROMPT_S => '%l>> ',
  :PROMPT_C => '.. ',
  :PROMPT_N => '.. ',
  :RETURN => "=> %s\n"
}

alias e exit