{{/* Defines the name of the chart */}}
{{- define "node-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/* Defines the Fully qualified name */}}
{{- define "node-app.fullname" -}}
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




{{/* Defines the Chart label with name and version */}}
{{- define "node-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Defins Selector labels
*/}}
{{- define "node-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "node-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/* Defines Common Labels */}}
{{- define "node-app.labels" -}}
helm.sh/chart: {{ include "node-app.chart" . }}
{{ include "node-app.selectorLabels" .}}
{{- if .Chart.Version }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- if .Release.Service }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
{{- end }}



{{/*
Defines the env variables
*/}}
{{- define "node-app.environmentVariables" -}}
{{- range $key, $value := .Values.env -}}
- name: {{ $key }}
  value: {{ $value | quote}}
{{- end }}
{{- end }}


{{/*
Define the image
*/}}
{{- define "node-app.image" -}}
{{- $imagerepo := required "Image Repository is required!" .Values.image.repository }}
{{- $imagetag := default "latest" .Values.image.tag }}
{{- printf "%s:%s" $imagerepo $imagetag }}
{{- end }}


