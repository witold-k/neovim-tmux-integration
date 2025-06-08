SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

$SCRIPT_DIR/setup_completion.sh > /dev/null || exit
$SCRIPT_DIR/setup_plugins.sh || exit

export TMUX=$(which tmux)
export LUA=$(which lua5.1)
export LUAR=$(which luarocks)
export NVIM=$(which nvim)

$SCRIPT_DIR/setup_as_root.sh || exit
$SCRIPT_DIR/setup_lua.sh || exit

