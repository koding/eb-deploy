if [ ! -n "$WERCKER_KODING_EB_DEPLOY_ACCESS_KEY" ]; then
  error 'Please specify access-key'
  exit 1
fi

if [ ! -n "$WERCKER_KODING_EB_DEPLOY_SECRET_KEY" ]; then
  error 'Please specify secret-key'
  exit 1
fi

if [ ! -n "$WERCKER_KODING_EB_DEPLOY_APP_NAME" ]; then
  error 'Please specify app-name'
  exit 1
fi

if [ ! -n "$WERCKER_KODING_EB_DEPLOY_ENV_NAME" ]; then
  error 'Please specify env-name'
  exit 1
fi

if [ ! -n "$WERCKER_KODING_EB_DEPLOY_VERSION_LABEL" ]; then
  error 'Please specify version-label'
  exit 1
fi

if [ ! -n "$WERCKER_KODING_EB_DEPLOY_BUCKET" ]; then
  error 'Please specify bucket'
  exit 1
fi

export AMAZON_ACCESS_KEY_ID=$WERCKER_KODING_EB_DEPLOY_ACCESS_KEY
export AMAZON_SECRET_ACCESS_KEY=$WERCKER_KODING_EB_DEPLOY_SECRET_KEY

$WERCKER_STEP_ROOT/eb-api/bin/elastic-beanstalk-create-application-version -a $WERCKER_KODING_EB_DEPLOY_APP_NAME -l $WERCKER_KODING_EB_DEPLOY_VERSION_LABEL -s $WERCKER_KODING_EB_DEPLOY_BUCKET

$WERCKER_STEP_ROOT/eb-api/bin/elastic-beanstalk-update-environment -e $WERCKER_KODING_EB_DEPLOY_ENV_NAME -l $WERCKER_KODING_EB_DEPLOY_VERSION_LABEL -d "update environment"
