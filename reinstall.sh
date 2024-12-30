SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd ~
rm -rf .config/nvim
rm -rf .local/share/nvim
$SCRIPT_DIR/setup.sh || exit

