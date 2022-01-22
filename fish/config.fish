set fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
end

zoxide init fish | source

set fish_plugins autojump vi-mode
set vi_mode_default vi_mode_normal

function fish_user_key_bindings
  bind -M insert \t forward-char
  bind -M insert \cl 'clear; commandline -f repaint'
end

function fish_mode_prompt
end
