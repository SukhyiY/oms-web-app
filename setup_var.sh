#!/bin/bash

export HIBFILE=./src/main/webapp/WEB-INF/hibernate.cfg.xml;


sed -i "s@db_url@$DB_URL@" $HIBFILE;
sed -i "s/db_pswd/$DB_PSSWD/" $HIBFILE ;
sed -i "s/db_usr/$DB_USR/" $HIBFILE ;
