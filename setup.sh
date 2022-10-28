#!/bin/bash

#create .bash_aliases if not exist
if [[ ! -e ~/.bash_aliases ]]; then
    # create file
    touch ~/.bash_aliases
    echo "created .bash_aliases file as it was missing"
fi

# reload alias
source ~/.bash_aliases

# enable alias use in script
shopt -s expand_aliases

# create alias if not exists
if [ "$(type -t dbt)" != 'alias' ]; then
    # configured a dbt alias
    echo "alias 'dbt=docker run -it --rm --name interpol_dbt -p 8080:8080 --env-file .env --network=interpol_network -v $(pwd):/usr/app/dbt -v $(pwd):/root/.dbt ghcr.io/dbt-labs/dbt-postgres:1.3.latest'" > ~/.bash_aliases
    echo "created an alias for dbt"

    # reload alias
    source ~/.bash_aliases

    # enable alias use in script
    shopt -s expand_aliases
fi

# test
echo "testing dbt connection..."
dbt debug