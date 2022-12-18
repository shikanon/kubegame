{{/*
Expand the name of the chart.
*/}}
{{- define "backends-php.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "backends-php.fullname" -}}
{{- if .Values.fullname }}
{{- .Values.fullname | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Values.name }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" $name .Release.Name  | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "backends-php.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "backends-php.labels" -}}
helm.sh/chart: {{ include "backends-php.chart" . }}
{{ include "backends-php.selectorLabels" . }}
{{- if .Values.imageTag }}
app.kubernetes.io/version: {{ .Values.imageTag | quote | trunc 63 | trimSuffix "-" }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Chart.AppVersion }}
helm.sh/chartVersion: {{ .Chart.AppVersion | quote }}
{{- end }}
app: {{ include "backends-php.name" . }}
version: {{ .Values.imageTag | default "latest" | quote | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "backends-php.selectorLabels" -}}
app.kubernetes.io/name: {{ include "backends-php.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

