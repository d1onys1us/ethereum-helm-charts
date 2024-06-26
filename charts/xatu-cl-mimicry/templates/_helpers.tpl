{{/*
Expand the name of the chart.
*/}}
{{- define "xatu-cl-mimicry.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "xatu-cl-mimicry.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "xatu-cl-mimicry.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "xatu-cl-mimicry.labels" -}}
helm.sh/chart: {{ include "xatu-cl-mimicry.chart" . }}
{{ include "xatu-cl-mimicry.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "xatu-cl-mimicry.selectorLabels" -}}
app.kubernetes.io/name: {{ include "xatu-cl-mimicry.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "xatu-cl-mimicry.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "xatu-cl-mimicry.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "xatu-cl-mimicry.metricsPort" -}}
{{ (split ":" .Values.config.metricsAddr)._1 | default ":9090" }}
{{- end -}}

{{- define "xatu-cl-mimicry.pprofPort" -}}
{{- if .Values.config.pprofAddr -}}
{{ (split ":" .Values.config.pprofAddr)._1 | default "6060" }}
{{- end -}}
{{- end -}}

{{- define "xatu-cl-mimicry.probePort" -}}
{{- if .Values.config.probeAddr -}}
{{ (split ":" .Values.config.probeAddr)._1 | default "8080" }}
{{- end -}}
{{- end -}}