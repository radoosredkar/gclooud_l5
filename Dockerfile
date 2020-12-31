#docker run -ti --name gcloud-cli gcr.io/google.com/cloudsdktool/cloud-sdk -v ~/sw/gcloud/L5/:/usr/src
FROM gcr.io/google.com/cloudsdktool/cloud-sdk

# set the working directory in the container
RUN mkdir /usr/src/l5data
WORKDIR /usr/src/l5data

#RUN echo "pip install -r /usr/src/web_collector/requirements.txt" > /usr/bin/build
#RUN echo "python /usr/src/web_collector/main.py" > /usr/bin/run
#RUN chmod +x /usr/bin/build
#RUN chmod +x /usr/bin/run
