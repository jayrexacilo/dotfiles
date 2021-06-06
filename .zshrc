alias l='ls -l --color'
alias la='ls -a --color'
alias lla='ls -la --color'
alias lt='ls --tree --color'
alias r='ranger'
alias cdt='cd /mnt/storage2/torrent && ranger'
alias cdm='cd /mnt/storage2/movies && ranger'
alias cdx='cd ~/programming/xplus/'
alias cdxd='cd ~/programming/xplus/dipcwd'
alias cdp='cd ~/programming/personal-projects'
alias nv='nvim'
alias td='transmission-daemon'
alias ta='transmission-remote -a '
alias tl='transmission-remote -l '

export TERM=xterm-256color

# Show OS info when opening a new terminal
neofetch

source ~/antigen.zsh


antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

antigen theme romkatv/powerlevel10k
# Tell Antigen that you're done.
antigen apply



# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/kzn/.sdkman"
[[ -s "/home/kzn/.sdkman/bin/sdkman-init.sh" ]] && source "/home/kzn/.sdkman/bin/sdkman-init.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/kzn/programming/xplus/gcloud/google-cloud-sdk/path.zsh.inc' ]; then . '/home/kzn/programming/xplus/gcloud/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/kzn/programming/xplus/gcloud/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/kzn/programming/xplus/gcloud/google-cloud-sdk/completion.zsh.inc'; fi
