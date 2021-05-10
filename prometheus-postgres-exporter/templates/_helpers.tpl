{{/* Name of the chart */}}
{{- define "prometheus-postgres-exporter.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Fullname */}}
{{- define "prometheus-postgres-exporter.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/* Create chart name and version as used by the chart label. */}}
{{- define "prometheus-postgres-exporter.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Common labels */}}

{{- define "prometheus-postgres-exporter.selector" -}}
app.kubernetes.io/name: {{ include "prometheus-postgres-exporter.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "prometheus-postgres-exporter.labels" -}}
{{ include "prometheus-postgres-exporter.selector" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/component: "Monitoring"
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ include "prometheus-postgres-exporter.chart" . }}
{{- end -}}

{{/* Compute hash of monitoring queries */}}
{{- define "prometheus-postgres-exporter.confighash" -}}
{{- tpl ($.Files.Get "prometheus-exporter-queries.yaml") $ | sha256sum | trunc 8 }}
{{- end -}}
