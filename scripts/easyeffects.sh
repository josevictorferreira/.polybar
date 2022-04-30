#!/usr/bin/env bash

get_sources() {
  output=$(easyeffects -p | grep "Output Presets")
  output=${output: 16}
  IFS=','
  for preset in $output; do
    echo $preset
  done
  IFS=' '
}


get_sources
