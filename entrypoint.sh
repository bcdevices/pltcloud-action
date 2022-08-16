#!/bin/bash -l

for i in "$@"
do
case $i in
    -p=*)
    PROJECT_UUID="${i#*=}"
    ;;
    -t=*)
    API_TOKEN="${i#*=}"
    ;;
    -d=*)
    DEPLOYMENT_GROUP_UUID="${i#*=}"
    ;;
    -a=*)
    AUTO_DEPLOY="${i#*=}"
    ;;
    -f=*)
    FILES="${i#*=}"
    ;;
    -v=*)
    VERSION="${i#*=}"
    ;;
    -ds=*)
    DESCRIPTION="${i#*=}"
    ;;
    -vvv=*)
    VERBOSE="${i#*=}"
    ;;
    -n=*)
    CHECK_NAME="${i#*=}"
    ;;
    -r=*)
    GITHUB_REPOSITORY="${i#*=}"
    ;;
    -o=*)
    GITHUB_REPOSITORY_OWNER="${i#*=}"
    ;;
    -s=*)
    GITHUB_SHA="${i#*=}"
    ;;
    *)
            # unknown option
    ;;
esac
done


# Construct environment arguments 

i=0
EXTERNAL_ID=$(uuidgen -r)
envVars=()

if [ ! -z "${GITHUB_REPOSITORY}" ]; then
  envVars[i]="_GITHUB_REPOSITORY=${GITHUB_REPOSITORY}" 
  i=$((i+1))
fi

if [ ! -z "${GITHUB_REPOSITORY_OWNER}" ]; then
  envVars[i]="_GITHUB_REPOSITORY_OWNER=${GITHUB_REPOSITORY_OWNER}" 
  i=$((i+1))
fi

if [ ! -z "${GITHUB_SHA}" ]; then
  envVars[i]="_GITHUB_SHA=${GITHUB_SHA}" 
  i=$((i+1))

  if [ ! -z "${EXTERNAL_ID}" ]; then
    envVars[i]="_CHECK_RUN_EXTERNAL_ID=${EXTERNAL_ID}" 
  i=$((i+1))
  fi

  if [ ! -z "${CHECK_NAME}" ]; then
    envVars[i]="_CHECK_NAME=${CHECK_NAME}" 
    i=$((i+1))
  fi

fi

# Construct PLTcloud upload arguments

i=0
cliArgs=$()


if [ ! -z "${PROJECT_UUID}" ]; then
  cliArgs[i]="-p ${PROJECT_UUID}" 
  i=$((i+1))
fi

if [ ! -z "${API_TOKEN}" ]; then
  cliArgs[i]="-t ${API_TOKEN}" 
  i=$((i+1))
fi

if [ ! -z "${DEPLOYMENT_GROUP_UUID}" ]; then
  cliArgs[i]="-d ${DEPLOYMENT_GROUP_UUID}" 
  i=$((i+1))
fi

if [ ! -z "${AUTO_DEPLOY}" ]; then
  cliArgs[i]="-a=${AUTO_DEPLOY}" 
  i=$((i+1))
fi

if [ ! -z "${FILES}" ]; then
  cliArgs[i]="-f ${FILES}" 
  i=$((i+1))
fi

if [ ! -z "${VERSION}" ]; then
  cliArgs[i]="-v ${VERSION}" 
  i=$((i+1))
fi

if [ ! -z "${DECRIPTION}" ]; then
  cliArgs[i]="-v ${DESCRIPTION}" 
  i=$((i+1))
fi

if [ ! -z "${VERBOSE}" ]; then
  cliArgs[i]="-vvv=${VERBOSE}" 
  i=$((i+1))
fi

if [ ${#envVars[@]} -gt 0 ]; then
  for flag in "${envVars[@]}"; do
    cliArgs[i]="-env ${flag}" 
    i=$((i+1))
  done
fi

# Execute

set -o noglob

pltcloud ${cliArgs[@]}
