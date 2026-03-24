apiVersion: v1
kind: Service
metadata:
  name: mychart
spec:
  type: {{ .Values.service.type }}
  selector:
    app: mychart
  ports:
    - port: {{ .Values.service.port }}
      targetPort: 80