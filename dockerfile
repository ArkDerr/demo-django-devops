# Es el “sistema operativo + Python” sobre el cual se construirá tu app.
FROM python:3.13-slim

# Evita archivos .pyc y muestra logs en tiempo real
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Carpeta de trabajo dentro del contenedor
WORKDIR /app

# Copia el archivo de dependencias e instala paquetes
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia el resto del proyecto al contenedor
COPY . .

# Variables de entorno para Django
ENV DJANGO_SETTINGS_MODULE=devopsdemo.settings \
    ALLOWED_HOSTS=*

# Expone el puerto 8000 (usado por Gunicorn/Django)
EXPOSE 8000

# Comando que arranca la aplicación con Gunicorn
CMD ["gunicorn", "-b", "0.0.0.0:8000", "devopsdemo.wsgi:application", "--workers", "2"]
