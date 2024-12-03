# Use the official RAPIDS image that includes cuML, Jupyter, and CUDA
FROM nvcr.io/nvidia/rapidsai/base:24.10-cuda12.5-py3.12

# Set up working directory
WORKDIR /workspace

# Install additional dependencies (with root privileges)
USER root
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-dev \
    git \
    curl \
    nvidia-utils-450 \
    && rm -rf /var/lib/apt/lists/*


RUN pip install --no-cache-dir nvidia-pyindex
# Copy the requirements.txt into the container
COPY requirements.txt /workspace/requirements.txt

# Install Python libraries from requirements.txt
RUN pip install --no-cache-dir -r /workspace/requirements.txt

RUN nvidia-smi
# Expose the port Jupyter will run on
EXPOSE 8888

# Start Jupyter Notebook when the container starts
CMD ["jupyter", "notebook", "--ip='0.0.0.0'", "--port=8888", "--no-browser", "--allow-root"]
