# --- STAGE 1: Builder Stage ---
# This stage installs all Python dependencies
FROM python:3.11-slim as builder

WORKDIR /app
COPY requirements.txt .

# Install dependencies into a dedicated site-packages directory
RUN pip install -r requirements.txt


# --- STAGE 2: Runtime Stage ---
# This stage creates the final, minimal image
FROM python:3.11-slim

# Set environment path to include custom site-packages directory
ENV PATH="/usr/local/bin:$PATH"

WORKDIR /app

# Copy the installed dependencies from the builder stage
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
 
# Copy the application code
COPY app.py .

EXPOSE 5000

CMD ["python", "app.py"]