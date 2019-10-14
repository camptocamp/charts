{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "puppetdb.name" -}}
{{- default .Chart.Name .Values.puppetdb.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "prometheus-puppetdb-exporter.name" -}}
{{- default "prometheus-puppetdb-exporter" .Values.prometheusPuppetdbExporter.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app names.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "puppetdb.fullname" -}}
{{- if .Values.puppetdb.fullnameOverride -}}
{{- .Values.puppetdb.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.puppetdb.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "prometheus-puppetdb-exporter.fullname" -}}
{{- if .Values.prometheusPuppetdbExporter.fullnameOverride -}}
{{- .Values.prometheusPuppetdbExporter.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.prometheusPuppetdbExporter.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-prometheus-puppetdb-exporter" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-prometheus-puppetdb-exporter" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "puppetdb.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
