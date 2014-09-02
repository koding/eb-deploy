if [ ! -n "$WERCKER_EB_DEPLOY_ACCESS_KEY" ]; then
  error 'Please specify access-key'
  exit 1
fi

if [ ! -n "$WERCKER_EB_DEPLOY_SECRET_KEY" ]; then
  error 'Please specify secret-key'
  exit 1
fi

if [ ! -n "$WERCKER_EB_DEPLOY_APP_NAME" ]; then
  error 'Please specify app-name'
  exit 1
fi

if [ ! -n "$WERCKER_EB_DEPLOY_ENV_NAME" ]; then
  error 'Please specify env-name'
  exit 1
fi

if [ ! -n "$WERCKER_EB_DEPLOY_VERSION_LABEL" ]; then
  error 'Please specify version-label'
  exit 1
fi

if [ ! -n "$WERCKER_EB_DEPLOY_APP_LOCATION" ]; then
  error 'Please specify bucket'
  exit 1
fi

export AMAZON_ACCESS_KEY_ID=$WERCKER_EB_DEPLOY_ACCESS_KEY
export AMAZON_SECRET_ACCESS_KEY=$WERCKER_EB_DEPLOY_SECRET_KEY
export EB_DESCRIPTION=$WERCKER_EB_DEPLOY_ENV_NAME-$WERCKER_GIT_BRANCH

$WERCKER_STEP_ROOT/eb-api/bin/elastic-beanstalk-create-application-version -a $WERCKER_EB_DEPLOY_APP_NAME -l $WERCKER_EB_DEPLOY_VERSION_LABEL -s $WERCKER_EB_DEPLOY_APP_LOCATION -d $EB_DESCRIPTION

$WERCKER_STEP_ROOT/eb-api/bin/elastic-beanstalk-update-environment -e $WERCKER_EB_DEPLOY_ENV_NAME -l $WERCKER_EB_DEPLOY_VERSION_LABEL -d $EB_DESCRIPTION-$WERCKER_GIT_COMMIT
