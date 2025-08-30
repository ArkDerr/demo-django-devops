# Es el “sistema operativo + Python” sobre el cual se construirá tu app.
FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Carpeta de trabajo dentro del contenedor
WORKDIR /app

# Copia el archivo de dependencias e instala paquetes
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Variables de entorno para Django
ENV DJANGO_SETTINGS_MODULE=devopsdemo.settings \
    ALLOWED_HOSTS=*

EXPOSE 8000

CMD ["gunicorn", "-b", "0.0.0.0:8000", "devopsdemo.wsgi:application", "--workers", "2"]