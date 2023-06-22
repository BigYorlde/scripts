#!/usr/bin/env bash
# Global vars

declare -r SSH_USER="BigYorlde"
declare -r SERVER_MASTER="my-patroni-cluster-master"
declare -r SERVER_SLAVE="my-patroni-cluster-slave"
declare -a cluster=("server-1" "server-2" "server-3")
declare -r PGUSER="postgres"

# Functions
check() {
  local list; local query; local check
  list=
  list=$(echo "$(ssh -q -t -o 'BatchMode=true' -o 'StrictHostKeyChecking=no' "${SSH_USER}@${SERVER_MASTER}" 'sudo patronictl list -f yaml 2> /dev/null' | tr -d ' ' | awk -F ":" '/^[MRS]/ {print $2}' | tr -d '\r')")
  check_patroni master $list
  if [ "$?" -eq 0 ]; then
    printf "Patroni cluster is OK.\n"
  fi
  list=
  list=$(echo "$(ssh -q -t -o 'BatchMode=true' -o 'StrictHostKeyChecking=no' "${SSH_USER}@${SERVER_SLAVE}" 'sudo patronictl list -f yaml 2> /dev/null' | tr -d ' ' | awk -F ":" '/^[MRS]/ {print $2}' | tr -d '\r')")
  check_patroni slave $list
  if [ "$?" -eq 0 ]; then
    printf "Patroni cluster is OK.\n"
  fi
  query='"select active from pg_replication_slots;"'
  check="$(ssh -q -t -o 'BatchMode=true' -o 'StrictHostKeyChecking=no' "${SSH_USER}@${SERVER_MASTER}" sudo psql -U $PGUSER -d postgres -qtAX -c ${QUERY} | tr -d '\n\r')"
  if [[ "$CHECK" == "ttt" ]]; then
    printf "Replication slot is active.\n"
  else
    printf "Replication slot is ${COLOR_RED}inactive${COLOR_DEFAULT}.\n"
  fi
}
check_patroni() {
  local member; local role; local state; local region; local status; local cluster_role
  member=(); role=(); state=(); status=; cluster_role="$1"
  shift 1
  while [ "$#" -gt 0 ]; do
    member+=("$1")
    role+=("$2")
    state+=("$3")
    shift 3
  done
  if ! [[ "${#member[@]}" -eq "${#cluster[@]}" ]]; then
    printf "${COLOR_RED}We don't have${COLOR_DEFAULT} all members in patroni cluster. Available members: ${MEMBER[@]}\n"
    return 1
  fi
  if [[ "$CLUSTER_ROLE" == "master" ]]; then
    for role in "${roles[@]}"; do
      if [ "$role" == "Leader" ]; then
        status="Leader"
        break
      fi
    done
    if ! [[ "$status" == "Leader" ]]; then
      printf "Patroni cluster doesn't have member with role - $cluster_role.\n"
      return 1
    fi
  elif [[ "$cluster_role" == "slave" ]]; then
    for role in "${role[@]}"; do
      if [ "$role" == "StandbyLeader" ]; then
        status="StandbyLeader"
        break
      fi
    done
    if ! [[ "$status" == "StandbyLeader" ]]; then
      printf "Patroni cluster doesn't have member with role - $cluster_role.\n"
      return 1
    fi
  fi
  for state in "${state[@]}"; do
    if ! [[ "$state" == "running" ]]; then
      printf "We have ${COLOR_RED}stopped${COLOR_DEFAULT} member in patroni cluster.\n"
      return 1
    fi
  done
}