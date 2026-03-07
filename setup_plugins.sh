SCRIPT_DIR="$(readlink -f $(cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd ))"

DEST_DIR=~/.config/nvim/
p=$DEST_DIR
if [ ! -d "$p" ];
then
    mkdir -p $p
fi

echo "INSTALLING Neovim plugins..."

# copy local files
cd $SCRIPT_DIR/plugins
echo "create links: $SCRIPT_DIR/plugins in $p .."

files=$(ls)
cd $p || exit
echo "install in $p"
for FILE in $files
do
    echo "install: $FILE"
    ln -sf $SCRIPT_DIR/plugins/$FILE .
done

echo "copy start scripts in ~/bin ..."

if [ ! -d ~/bin ];
then
    mkdir ~/bin
fi

cd $SCRIPT_DIR/exe
for FILE in $(ls)
do
    echo "install: $FILE"
    ln -sf $SCRIPT_DIR/exe/$FILE ~/bin
done

