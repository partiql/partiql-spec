function run_check {
  echo "`date`: RUNNING $@" >&2
  "$@"
  local ERR=$?
  if [ $ERR -ne 0 ]; then
    echo "`date`: FAILED $@" >&2
    exit 1
  fi
  echo "`date`: DONE $@" >&2
  echo >&2
}
