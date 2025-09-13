# --- Build Stage ---
FROM python:3.11-slim

# Set working directory
WORKDIR /home/app

# Install poetry
RUN pip install poetry

# Copy only dependency-defining files
COPY pyproject.toml ./

# Install dependencies, without dev dependencies, into a virtual environment
RUN poetry config virtualenvs.create false && \
    poetry install --no-root --without dev --no-interaction --no-ansi

COPY ./app ./app
COPY gunicorn_conf.py .
COPY startup.sh .
RUN chmod +x /home/app/startup.sh

# Expose the port the app runs on
EXPOSE 8080

# Command to run the application using our custom Gunicorn config file.
# This ensures structured JSON logging is used in production.
CMD ["/home/app/startup.sh"]
