# Use an official Miniconda base image
FROM continuumio/miniconda3

# Set the working directory in the container
WORKDIR /app

# Copy the environment.yml file to the container
COPY environment.yml .

# Create the Conda environment and clean up
RUN conda env create --file environment.yml && conda clean -afy

# Ensure the environment is activated by default
ENV PATH=/opt/conda/envs/29-11-24_env/bin:$PATH

# Install additional dependencies using pip and configure JupyterLab widgets
# RUN /opt/conda/envs/29-11-24_env/bin/conda install jupyter ipywidgets tqdm jupyterlab_widgets && \
#     /opt/conda/envs/29-11-24_env/bin/jupyter nbextension enable --py widgetsnbextension

# Clean up the environment.yml file to reduce image size
RUN rm environment.yml

# Copy the Jupyter Notebook files to the container
COPY core/ /app/core/
COPY raw_data /app/raw_data/


# Expose the Jupyter Notebook port
EXPOSE 8888

# Set the command to run Jupyter Notebook
CMD ["bash", "-c", "source activate 29-11-24_env && jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root --notebook-dir=/app/core"]