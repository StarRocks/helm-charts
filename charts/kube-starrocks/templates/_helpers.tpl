{{/*
Expand the name of the chart.
*/}}
{{- define "kube-starrocks.name" -}}
{{- default .Chart.Name .Values.nameOverride -}}
{{- end }}


{{- define "kube-starrocks.operator.namespace" -}}
{{- default "starrocks" .Values.starrocksOperator.namespaceOverride }}
{{- end }}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kube-starrocks.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kube-starrocks.labels" -}}
helm.sh/chart: {{ include "kube-starrocks.chart" . }}
{{ include "kube-starrocks.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "kube-starrocks.operator.serviceAccountName" -}}
{{ default (include "kube-starrocks.name" .) .Values.starrocksOperator.serviceAccountName }}
{{- end }}
{{/*
Selector labels
*/}}
{{- define "kube-starrocks.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kube-starrocks.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
starrockscluster
*/}}

{{- define "starrockscluster.name" -}}
{{ default (include "kube-starrocks.name" .) .Values.starrocksCluster.name }}
{{- end }}

{{- define "starrockscluster.namespace" -}}
{{ default .Release.Namespace .Values.starrocksCluster.namespace }}
{{- end }}


{{- define "starrockscluster.fe.name" -}}
{{- print (include "kube-starrocks.name" . ) "fe" }}
{{- end }}

{{- define "starrockscluster.cn.name" -}}
{{- print (include "kube-starrocks.name" . ) "cn" }}
{{- end }}

{{- define "starrockscluster.be.name" -}}
{{- print (include "kube-starrocks.name" .) "be" }}
{{- end }}

{{- define "starrockscluster.fe.config" -}}
fe.conf: |-
{{- if .Values.starrocksFESpec.config }}
{{ .Values.starrocksFESpec.config | indent 2 }}
{{- end }}
{{- end }}

{{- define "starrockscluster.cn.config" -}}
cn.conf: |-
{{- if .Values.starrocksCnSpec.config | indent 2 }}
{{ .Values.starrocksCnSpec.config | indent 2 }}
{{- end }}
{{- end }}

{{- define "starrocksclster.be.config" -}}
be.conf: |-
{{- if .Values.starrocksBeSpec.config | indent 2 }}
{{ .Values.starrocksBeSpec.config | indent 2 }}
{{- end }}
{{- end }}