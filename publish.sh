#!/bin/bash

SSH_HOST=$1
SSH_TARGET_DIR=$2

ssh $SSH_HOST SSH_TARGET_DIR=$SSH_TARGET_DIR 'bash -s' <<'ENDSSH'
cd $SSH_TARGET_DIR
chgrp -R www-data *
ENDSSH