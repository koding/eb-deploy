# koding-eb-deploy

```
deploy:
  steps:
  - koding/eb-deploy@0.0.5:
      access-key: $S3_KEY_ID
      secret-key: $S3_KEY_SECRET
      app-name: koding
      env-name: prod
      bucket: deployments
      version-label: 0.0.1
```
