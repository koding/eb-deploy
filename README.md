# eb-deploy

```
deploy:
  steps:
  - koding/eb-deploy@0.0.29:
      access-key: $S3_KEY_ID
      secret-key: $S3_KEY_SECRET
      app-name: <enter app name>
      env-name: <enter env name>
      version-label: <enter version label>
      region: <enter region>
      s3-bucket: <enter s3 bucket name>
      s3-key: <enter file name>
```
