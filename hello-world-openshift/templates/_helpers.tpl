{{- define "chart.api_version" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 -}}
{{- end -}}


{{- define "chart.release_labels" }}
app: {{ printf "%s-%s" .Release.Name .Chart.Name | trunc 63 }}
version: {{ .Chart.Version }}
release: {{ .Release.Name }}
{{- end }}

{{- define "chart.full_name" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 -}}
{{- end -}}

{{- define "chart.config_map_checksum" }}
annotations:
  checksum/config-map: {{ include (print $.Chart.Name "/templates/config-map.yaml") . | sha256sum }}
{{- end -}}
