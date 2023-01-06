SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if [ "$USER" != "root" ];
then
    echo "user is not root - executing as root"
    sudo -E bash $0
    exit
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

echo "TMUX=$TMUX"
if [ -z "$TMUX" ];
then
    TMUX=$(which tmux)
fi
if [ -z "$TMUX" ];
then
    echo "## tmux not installed - install tmux"
    apt install -y tmux
fi

LUA=$(which lua5.1)
if [ -z "$LUA" ];
then
    echo "## lua not installed - install lua5.1"
    apt install -y lua5.1
fi

LUAR=$(which luarocks)
if [ -z "$LUAR" ];
then
    echo "## luarocks not installed - install luarocks"
    apt install -y luarocks
fi

echo "NVIM=$NVIM"
if [ -z "$NVIM" ];
then
    NVIM=$(which nvim)
fi 
if [ -z "$NVIM" ];
then
    echo "## neovim not installed - install neovim"
    apt install -y neovim
fi

