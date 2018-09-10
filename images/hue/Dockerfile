FROM gethue/hue

RUN apt update --fix-missing
RUN apt install curl -y

COPY hue.ini desktop/conf/hue.ini
