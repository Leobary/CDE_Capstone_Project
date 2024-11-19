# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY travel_agency_app.py /app
COPY app_requirements.txt /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r app_requirements.txt

# Set the environment variable for AWS region (optional but good practice)
ENV AWS_REGION=eu-north-1

# Make port 80 available to the world outside this container (if needed)
EXPOSE 8080

# Run extract_to_s3.py when the container launches
CMD ["python", "travel_agency_app.py"]
