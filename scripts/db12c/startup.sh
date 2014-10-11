#!/bin/bash

export TMP=/tmp
export TMPDIR=$TMP
export PATH=/usr/sbin:/usr/local/bin:$PATH
export ORACLE_HOSTNAME=db12c
export ORACLE_UNQNAME=orcl

export ORACLE_SID=orcl
ORAENV_ASK=NO
. oraenv
ORAENV_ASK=YES

# Start Listener
lsnrctl start

# Start Database
sqlplus / as sysdba << EOF
STARTUP;
EXIT;
EOF