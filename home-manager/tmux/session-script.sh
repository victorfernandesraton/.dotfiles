FZF_RESULT=$(fd -H -td -d 1 . $HOME/git  | fzf)


# get folder name
FOLDER=$(basename $FZF_RESULT)

# lookup tmux session name
SESSION=$(tmux list-sessions | grep $FOLDER | awk '{print $1}')
SESSION=${SESSION//:/}

# check if variable is empty 
# if not currently in tmux
if [ -z "$TMUX" ]; then
  # tmux is not active
  echo "is not tmux"
  if [ -z "$SESSION" ]; then
    # session does not exist
    echo "session does not exist"
    # create session
    tmux new-session -s $FOLDER -c $FZF_RESULT
  else
    # session exists
    echo "session exists"
    # attach to session
    tmux attach -t $SESSION
  fi
else
  # tmux is active
  echo "is tmux"
  if [ -z "$SESSION" ]; then
    # session does not exist
    echo "session does not exist"
    # jump to directory
    cd $FZF_RESULT
    # create session
    tmux new-session -d -s $FOLDER -c $FZF_RESULT
    # attach to session
    tmux switch-client -t $FOLDER
  else
    # session exists
    echo "session exists"
    # attach to session
    # switch to tmux session
    tmux switch-client -t $SESSION
  fi
fi
