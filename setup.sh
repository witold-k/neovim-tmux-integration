SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

DEST_DIR=~/.config/nvim/
if [ ! -d "$DEST_DIR" ];
then
    mkdir -p $DEST_DIR
fi

echo "INSTALLING Neovim plugins..."
echo "create links in $DEST_DIR" 

# copy local files
cd $SCRIPT_DIR/plugins
for FILE in $(ls)
do
    echo "install: $FILE"
    ln -sf $SCRIPT_DIR/plugins/$FILE $DEST_DIR
done

if [ ! -d ~/bin ];
then
    mkdir ~/bin
fi

cd $SCRIPT_DIR/
cp exe/nide* exe/ned* ~/bin/

export TMUX=$(which tmux)
export LUA=$(which lua5.1)
export LUAR=$(which luarocks)
export NVIM=$(which nvim)

./setup_as_root.sh
./setup_lua.sh

if [ ! -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ];
then
    # install neovim packer plugin
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
        ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

