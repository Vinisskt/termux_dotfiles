# Zsh History configuration
setopt HIST_IGNORE_DUPS          # Do not record an entry that was just recorded.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_SAVE_NO_DUPS         # Do not write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
