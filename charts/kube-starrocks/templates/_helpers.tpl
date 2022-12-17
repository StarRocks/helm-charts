{{/*
Expand the name of the chart.
*/}}
{{- define "kube-starrocks.name" -}}
{{- default .Chart.Name .Values.nameOverride -}}
{{- end }}


{{- define "kube-starrocks.operator.namespace" -}}
{{- default .Release.Namespace .Values.starrocksOperator.namespaceOverride }}
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
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "kube-starrocks.operator.serviceAccountName" -}}
{{ default (include "kube-starrocks.name" .) .Values.starrocksOperator.serviceAccountName }}
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
{{- print (include "kube-starrocks.name" .) "-fe" }}
{{- end }}

{{- define "starrockscluster.cn.name" -}}
{{- print (include "kube-starrocks.name" .) "-cn" }}
{{- end }}

{{- define "starrockscluster.be.name" -}}
{{- print (include "kube-starrocks.name" .) "-be" }}
{{- end }}

{{- define "starrockscluster.be.configmap.name" -}}
{{- print (include "starrockscluster.be.name" .) "-cm" }}
{{- end }}

{{- define "starrockscluster.fe.configmap.name" -}}
{{- print (include "starrockscluster.fe.name" .) "-cm" }}
{{- end }}

{{- define "starrockscluster.cn.configmap.name" -}}
{{- print (include "starrockscluster.cn.name" .) "-cm" }}
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

{{- define "starrockscluster.fe.meta.path" -}}
{{- print "/opt/starrocks/fe/meta" }}
{{- end }}

{{- define "starrockscluster.be.data.path" -}}
{{- print "/opt/starrocks/be/storage" }}
{{- end }}
