#!/bin/bash

ssh-keygen -t rsa -P "" -f $HOME/.ssh/id_rsa > /dev/null
cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
chmod 700 $HOME/.ssh
chmod 640 $HOME/.ssh/authorized_keys
