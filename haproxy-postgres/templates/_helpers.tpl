{{/* Name of the chart */}}
{{- define "haproxy-postgres.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Fullname */}}
{{- define "haproxy-postgres.fullname" -}}
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
{{- define "haproxy-postgres.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Common labels */}}

{{- define "haproxy-postgres.selector" -}}
app.kubernetes.io/name: {{ include "haproxy-postgres.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "haproxy-postgres.labels" -}}
{{ include "haproxy-postgres.selector" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/component: "LoadBalancer"
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ include "haproxy-postgres.chart" . }}
{{- end -}}


{{/* Compute hash of configuration */}}
{{- define "haproxy-postgres.confighash" -}}
{{- tpl ($.Files.Get "haproxy.cfg") . | sha256sum | trunc 8 }}
{{- end -}}
