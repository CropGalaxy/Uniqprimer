# Use the official Python image from the Docker Hub
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Install dependencies for MUMmer (including nucmer)
RUN apt-get update && apt-get install -y \
    mummer \
    && rm -rf /var/lib/apt/lists/*

# Copy all files from the current directory to /app in the container
COPY . /app

# Make the shell script executable
RUN chmod +x /app/uniqprimer.sh

# Install the required Python packagesa
RUN pip install --no-cache-dir -r /app/uniqprimer-0.5.0/requirements.txt

# Set the entry point to the shell script
ENTRYPOINT ["/app/uniqprimer.sh"]
CMD ["-i", "/app/data/PXO99.fa", "-x", "/app/data/BLS256.fa", "--productsizerange", "100-300", "--primersize", "20", "--minprimersize", "18", "--crossvalidate", "--keeptempfiles", "--maxprimersize", "27", "-o", "/app/data/5Aug2024_PX099-BLS256_primers.out", "-f", "/app/data/5Aug2024.fa", "-l", "/app/data/5Aug2024.log"]

