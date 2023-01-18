# FIXME
#
# later: local install lua version could be used 
#


if [ "$USER" != "root" ];
then
    echo "user is not root - executing as root"
    sudo -E bash $0
    exit
fi


LUA=$(lua -v 2>&1)


# check for LuaFileSystem

# in case lua is a custom installation, 
# not that one from the current linux distribution
LUA_VER=$(echo $LUA | awk '{print $2}')
LUA_VER2=$(echo $LUA_VER | awk -F '.' '{print $1 "." $2}')
LUA_DIR=$(readlink -m $(which lua)/../..) 

# LUA_INSTALL="luarocks --local --lua-version $LUA_VER2 --lua-dir $LUA_DIR install luafilesystem path"
echo $LUA_INSTALL
#$($LUA_INSTALL)
luarocks install luafilesystem 
luarocks install path
luarocks install penlight
