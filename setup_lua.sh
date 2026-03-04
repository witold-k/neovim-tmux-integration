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

apt install -y lua5.1 liblua5.1-0-dev lua5.4 liblua5.4-dev
# LUA_INSTALL="luarocks --local --lua-version $LUA_VER2 --lua-dir $LUA_DIR install luafilesystem path"
echo $LUA_INSTALL
#$($LUA_INSTALL)
luarocks --lua-version=5.1 install luafilesystem
luarocks --lua-version=5.1 install luasystem
luarocks --lua-version=5.1 install luv
luarocks --lua-version=5.1 install path
luarocks --lua-version=5.1 install penlight

luarocks --lua-version=5.4 install luafilesystem
luarocks --lua-version=5.4 install luasystem
luarocks --lua-version=5.4 install luv
luarocks --lua-version=5.4 install path
luarocks --lua-version=5.4 install penlight
