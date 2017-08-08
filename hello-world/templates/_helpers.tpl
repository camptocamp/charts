{{- define "hello-world.release_labels" }}
app: {{ printf "%s-%s" .Release.Name .Chart.Name | trunc 63 }}
version: {{ .Chart.Version }}
release: {{ .Release.Name }}
{{- end }}

{{- define "hello-world.full_name" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 -}}
{{- end -}}

{{- define "hello-world.config_map_checksum" }}
annotations:
  checksum/config-map: {{ include (print $.Chart.Name "/templates/config-map.yaml") . | sha256sum }}
{{- end -}}
