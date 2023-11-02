FROM canyan/janus-gateway:master

# Install dependencies
RUN apt update -y
RUN apt install python3 python3-pip ffmpeg -y
# Copy files and install python libs
WORKDIR /server
COPY . .
RUN pip3 install -r /server/ffmpeg-endpoint/requirements.txt
# Expose ports
EXPOSE 4000
EXPOSE 4001
EXPOSE 8088
EXPOSE 8089
EXPOSE 8000
EXPOSE 7088
EXPOSE 7089
# Run launch script
RUN chmod +x launch.sh
CMD ["/server/launch.sh"]