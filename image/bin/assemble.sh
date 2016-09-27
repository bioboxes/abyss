#!/bin/bash

set -o errexit
set -o nounset
set -o xtrace

READS=$(biobox_args.sh 'select(has("fastq")) | .fastq | map(.value) | join(" ")')
FLAGS=$(fetch_task_from_taskfile.sh ${TASKFILE} $1)

cd $(mktemp -d)

eval abyss-pe name=genome ${FLAGS} in="${READS}"
cp genome-contigs.fa ${OUTPUT}/contigs.fa

cat << EOF > ${OUTPUT}/biobox.yaml
version: 0.9.0
arguments:
  - fasta:
    - id: contigs_1
      value: contigs.fa
      type: contigs
EOF
