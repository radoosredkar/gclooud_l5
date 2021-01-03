#docker run -ti --name gcloud-cli gcr.io/google.com/cloudsdktool/cloud-sdk -v ~/sw/gcloud/L5/:/usr/src
FROM gcr.io/google.com/cloudsdktool/cloud-sdk

# set the working directory in the container
RUN mkdir /usr/src/l5data
WORKDIR /usr/src/l5data

# Install cron
RUN apt-get -y install cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log


RUN echo "cp *.csv backup" >> /usr/bin/run
RUN echo "gsutil mv /usr/src/l5data/*.csv gs://tractor-data" >> /usr/bin/run
RUN echo "date" >> /usr/bin/run

RUN chmod +x /usr/bin/run

# Setup cron job
RUN (crontab -l ; echo "* * * * *  /usr/bin/run >> /var/log/cron.log") | crontab

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log
