apiVersion: apps/v1
kind: Deployment
metadata:
  name: mychart
  labels:
    app: mychart
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: mychart
  template:
    metadata:
      labels:
        app: mychart
    spec:
      containers:
        - name: mychart
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          ports:
            - containerPort: 80