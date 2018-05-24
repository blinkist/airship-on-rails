#!/bin/bash

if [ '$TASK_TYPE' == 'worker' ]
then
  echo 'Starting worker...'
  shoryuken -R -C ./config/shoryuken.yml
else
  echo 'Starting web ... '
  bundle exec bin/rails s -p 3000 -b '0.0.0.0'
fi
