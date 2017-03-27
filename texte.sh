#!/bin/bash
user="anderson"
pass="metallica"
t="terms"
mysql -u$user -p$pass <<EOF
use history_db;
CREATE TABLE t1 select * from $t;
EOF
