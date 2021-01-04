# Google cloud container with gcloud and gsutil tools included
FROM gcr.io/google.com/cloudsdktool/cloud-sdk

# set the working directory in the container
RUN mkdir /usr/src/l5data
WORKDIR /usr/src/l5data

# Install cron
RUN apt-get -y install cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log


# Copy csvs to backup folder and send them to google storage
RUN echo "cp *.csv backup" >> /usr/bin/run
RUN echo "gsutil mv /usr/src/l5data/*.csv gs://rado-060577-test-bucket" >> /usr/bin/run
RUN echo "date" >> /usr/bin/run

RUN chmod +x /usr/bin/run

# Setup cron job to run each day at 15:00
RUN (crontab -l ; echo "0 15 * * *  /usr/bin/run >> /var/log/cron.log") | crontab

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log
