#!/bin/sh

set -e

cd %(project_root)s

. ../bin/activate
. /etc/default/marvin

exec bin/hubot -a slack
