#!/bin/bash

# reload alias
source ~/.bash_aliases

# enable alias use in script
shopt -s expand_aliases

# build dbt
dbt clean && dbt deps && dbt build && dbt docs generate && dbt docs serve