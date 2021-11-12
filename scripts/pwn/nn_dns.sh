#!/usr/bin/env bash
nn_dig_iter (){
    print -z 'for d in $(cat domain.lst); do echo "Domain: $d"; dig +short $d; done'
}
