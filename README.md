# eb-deploy

```
deploy:
  steps:
  - koding/eb-deploy@0.0.1:
      access-key: $S3_KEY_ID
      secret-key: $S3_KEY_SECRET
      app-name: koding
      env-name: prod
      s3-app-location: deployments/0.0.1.tgz
      version-label: 0.0.1
```
