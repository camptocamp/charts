{{- define "gitlab-runner.cache_s3" }}
- name: CACHE_TYPE
  value: {{ default "" .Values.runners.cache.cacheType | quote }}
- name: CACHE_PATH
  value: {{ default "" .Values.runners.cache.cachePath | quote }}
{{-   if .Values.runners.cache.cacheShared }}
- name: CACHE_SHARED
  value: "true"
{{-   end }}

{{-   if eq .Values.runners.cache.cacheType "s3" }}
- name: S3_SERVER_ADDRESS
  value: {{ template "gitlab-runner.cache.s3ServerAddress" . }}
- name: S3_BUCKET_NAME
  value: {{ default "" .Values.runners.cache.s3BucketName | quote }}
- name: S3_BUCKET_LOCATION
  value: {{ default "" .Values.runners.cache.s3BucketLocation | quote }}
{{-     if .Values.runners.cache.s3CacheInsecure }}
- name: S3_CACHE_INSECURE
  value: "true"
{{-     end }}
{{-   end }}

{{-   if eq .Values.runners.cache.cacheType "gcs" }}
- name: CACHE_GCS_ACCESS_ID
  value: {{ default "" .Values.runners.cache.gcsAccessID | quote }}
- name: CACHE_GCS_PRIVATE_KEY
  value: {{ default "" .Values.runners.cache.gcsPrivateKey | quote }}
- name: CACHE_GCS_BUCKET_NAME
  value: {{ default "" .Values.runners.cache.gcsBucketName | quote }}
{{-   end }}

{{- end -}}
