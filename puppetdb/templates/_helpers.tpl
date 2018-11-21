{{- define "puppetdb.release_labels" }}
app: {{ printf "%s-%s" .Release.Name .Chart.Name | trunc 63 }}
version: {{ .Chart.Version }}
release: {{ .Release.Name }}
{{- end }}

{{- define "puppetdb.name" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 -}}
{{- end -}}

{{- define "puppetdb.config_map_checksum" }}
annotations:
  checksum/config-map: {{ include (print $.Chart.Name "/templates/config-map.yaml") . | sha256sum }}
{{- end -}}
