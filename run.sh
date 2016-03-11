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

if [ ! -n "$WERCKER_EB_DEPLOY_S3_BUCKET" ]; then
  error 'Please specify s3 bucket'
  exit 1
fi

if [ ! -n "$WERCKER_EB_DEPLOY_S3_KEY" ]; then
  error 'Please specify s3 key'
  exit 1
fi

if [ ! -n "$WERCKER_EB_DEPLOY_REGION" ]; then
  #set default region as us-east-1
  export WERCKER_EB_DEPLOY_REGION="us-east-1"
fi

info 'Installing the AWS CLI...';
sudo pip install awscli;


mkdir -p $HOME/.aws
echo '[default]' > $HOME/.aws/config
echo 'output = json' >> $HOME/.aws/config
echo "region = $WERCKER_EB_DEPLOY_REGION" >> $HOME/.aws/config
echo "aws_access_key_id = $WERCKER_EB_DEPLOY_ACCESS_KEY" >> $HOME/.aws/config
echo "aws_secret_access_key = $WERCKER_EB_DEPLOY_SECRET_KEY" >> $HOME/.aws/config


# set default values for AWS CLI tool
export AMAZON_ACCESS_KEY_ID=$WERCKER_EB_DEPLOY_ACCESS_KEY
export AMAZON_SECRET_ACCESS_KEY=$WERCKER_EB_DEPLOY_SECRET_KEY
export AWS_DEFAULT_REGION=$WERCKER_EB_DEPLOY_REGION

# create description for app deployment
export EB_DESCRIPTION=$WERCKER_EB_DEPLOY_ENV_NAME,$WERCKER_GIT_BRANCH

aws s3 cp --acl private "$WERCKER_EB_DEPLOY_S3_KEY" "s3://$WERCKER_EB_DEPLOY_S3_BUCKET"

aws elasticbeanstalk create-application-version \
    --region $WERCKER_EB_DEPLOY_REGION \
    --application-name $WERCKER_EB_DEPLOY_APP_NAME \
    --version-label $WERCKER_EB_DEPLOY_VERSION_LABEL \
    --description $EB_DESCRIPTION \
    --source-bundle "{\"S3Bucket\":\"$WERCKER_EB_DEPLOY_S3_BUCKET\", \"S3Key\":\"$WERCKER_EB_DEPLOY_S3_KEY\"}"

aws elasticbeanstalk update-environment \
    --environment-name $WERCKER_EB_DEPLOY_ENV_NAME \
    --description $EB_DESCRIPTION,$WERCKER_GIT_COMMIT \
    --version-label $WERCKER_EB_DEPLOY_VERSION_LABEL
