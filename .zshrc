# ===========================================================
# 0. FASTFETCH
# ===========================================================
fastfetch

# ===========================================================
# 1. INSTANT PROMPT — doit être en tout premier
# ===========================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ===========================================================
# 2. ZINIT
# ===========================================================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[[ ! -d "$ZINIT_HOME" ]] && mkdir -p "$(dirname $ZINIT_HOME)" && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# ===========================================================
# 3. POWERLEVEL10K — synchrone (obligatoire pour instant prompt)
# ===========================================================
zinit ice depth=1
zinit light romkatv/powerlevel10k

# ===========================================================
# 4. PLUGINS — chargement différé
# ===========================================================
zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light zsh-users/zsh-completions

zinit ice wait lucid
zinit light Aloxaf/fzf-tab

# zsh-syntax-highlighting doit être chargé EN DERNIER
zinit ice wait lucid atinit"zicompinit; zicdreplay"
zinit light zsh-users/zsh-syntax-highlighting

# ===========================================================
# 5. SNIPPETS OMZ — différé
# ===========================================================
zinit ice wait lucid; zinit snippet OMZL::git.zsh
zinit ice wait lucid; zinit snippet OMZP::git
zinit ice wait lucid; zinit snippet OMZP::sudo
zinit ice wait lucid; zinit snippet OMZP::command-not-found

# ===========================================================
# 6. SHELL INTEGRATIONS
# ===========================================================
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# ===========================================================
# 7. KEYBINDINGS
# ===========================================================
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# ===========================================================
# 8. HISTORY
# ===========================================================
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space
setopt hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

# ===========================================================
# 9. COMPLETION STYLING
# ===========================================================
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ===========================================================
# 10. ALIASES
# ===========================================================
alias ls='ls --color'
alias la='ls -la --color'
alias ll='ls -lh --color'
alias vim='nvim'
alias c='clear'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
alias diff='diff --color=auto'
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

# ===========================================================
# 11. CONDA — lazy load (évite ~150ms de délai au démarrage)
# ===========================================================
conda() {
    unfunction conda
    local __conda_setup
    __conda_setup="$('/home/henri-alvin/Logiciel/anaconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/henri-alvin/Logiciel/anaconda3/etc/profile.d/conda.sh" ]; then
            . "/home/henri-alvin/Logiciel/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/henri-alvin/Logiciel/anaconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    conda "$@"
}

# ===========================================================
# 12. POWERLEVEL10K CONFIG
# ===========================================================
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# ===========================================================
# 13. YT-DLP SHORTCUTS
# ===========================================================
[[ -f ~/.config/yt-dlp/functions.zsh ]] && source ~/.config/yt-dlp/functions.zsh
