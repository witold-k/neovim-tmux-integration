#!/bin/bash

if [ -z "$KEEP_ROOT" ];
then

if [[ $SYSTEM_UID != 0 ]];
then
    NAME=$(id $SYSTEM_UID -un 2> /dev/null)
    if [ ! -z "$NAME" ];
    then
        userdel $NAME
    fi
    useradd --home-dir /home/${SYSTEM_NAME}_loc --uid $SYSTEM_UID $SYSTEM_NAME
    mkdir -p /home/${SYSTEM_NAME}_loc
    chown $SYSTEM_NAME:$SYSTEM_NAME /home/${SYSTEM_NAME}_loc
    HOME=/home/${SYSTEM_NAME}_loc
    ln -s /home/${SYSTEM_NAME}/.ssh /home/${SYSTEM_NAME}_loc/.ssh
    chown $SYSTEM_NAME:$SYSTEM_NAME /opt
fi

echo "DIR:    $(pwd)"
echo "PARAMS: $@"
runuser -m -u $SYSTEM_NAME -g $SYSTEM_NAME -- $@

else
    runuser -m -s /usr/bin/bash -c "$@"
fi

