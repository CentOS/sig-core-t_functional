#!/bin/bash
# This script would process all tests, one by one, so that we can have a look at which one[s] failed as a whole result
for i in success fail;do
  test -e $i && rm $i
done

time for i in tests/* ; do 
  ./runtests.sh ${i/tests\//} && echo ${i/tests\//} >> success || echo ${i/tests\//} >> fail
done

wc -l fail success

