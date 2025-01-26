# Use the official Python runtime image
FROM python:3.12
 
# fix pip with user
RUN useradd -m dev
USER dev
COPY --chown=dev:dev . .
# Create the app directory
RUN mkdir /home/dev/app
 
# Set the working directory inside the container
WORKDIR /home/dev/app
 
# Set environment variables 
# Prevents Python from writing pyc files to disk
ENV PYTHONDONTWRITEBYTECODE=1
#Prevents Python from buffering stdout and stderr
ENV PYTHONUNBUFFERED=1 
 
# Upgrade pip
RUN pip install --upgrade pip 
 
# Copy the Django project  and install dependencies
COPY v1.requirements.txt  /home/dev/app/
 
# run this command to install all dependencies 
#RUN pip install --no-cache-dir -r requirements.txt
#RUN cat v1.requirements.txt | xargs -n 1 pip install --no-cache-dir --no-warn-script-location --user
RUN pip install -r v1.requirements.txt --no-cache-dir --no-warn-script-location --user 
 
# Copy the Django project to the container
RUN ls && pwd
COPY . /home/dev/app/
 
# Expose the Django port
EXPOSE 8000

# Run Django’s development server

CMD ["sh", "./scripts/start.sh"]