# Use official Python image
FROM python:3.9

# Set working directory inside the container
WORKDIR /app

# Copy and install dependencies first (Better caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .

# Set Python path to avoid import issues
ENV PYTHONPATH=/app

# Expose the application port
EXPOSE 5000

# Run Flask application
CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]
