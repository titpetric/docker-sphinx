#!/bin/bash
#
# @author leodido

indexer --all --rotate "$@"
. searchd.sh