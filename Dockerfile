
# Use the official Python image from Docker Hub
FROM python:3.11-slim

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    pkg-config \
    libmariadb-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy the requirements file into the container
COPY requirements.txt requirements.txt

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Set environment variables
ENV FLASK_APP=app.py

# Expose the port that the app runs on
EXPOSE 8080

# Run the application
CMD ["gunicorn", "-b", ":8080", "app:app"]



# docker build -t gcr.io/webgradient-01/flask-todo-app .
# gcloud builds submit --tag gcr.io/webgradient-01/flask-todo-app
# gcloud run deploy flask-todo-app \
#   --image gcr.io/webgradient-01/flask-todo-app \
#   --platform managed \
#   --region europe-central2 \
#   --allow-unauthenticated

