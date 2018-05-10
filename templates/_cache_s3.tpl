{{- define "cache_s3" }}
- name: CACHE_TYPE
  value: {{ default "" .Values.runners.cache.cacheType | quote }}
- name: S3_SERVER_ADDRESS
  value: {{ default "" .Values.runners.cache.s3ServerAddress | quote }}
- name: S3_ACCESS_KEY
  valueFrom:
    secretKeyRef:
      name: s3access
      key: accessKey
- name: S3_SECRET_KEY
  valueFrom:
    secretKeyRef:
      name: s3access
      key: secretKey
- name: S3_BUCKET_NAME
  value: {{ default "" .Values.runners.cache.s3BucketName | quote }}
- name: S3_BUCKET_LOCATION
  value: {{ default "" .Values.runners.cache.s3BucketLocation | quote }}
- name: S3_CACHE_INSECURE
  value: {{ default "" .Values.runners.cache.s3CacheInsecure | quote }}
- name: S3_CACHE_PATH
  value: {{ default "" .Values.runners.cache.s3CachePath | quote }}
- name: CACHE_SHARED
  value: {{ default "" .Values.runners.cache.cacheShared | quote }}
{{- end -}}
