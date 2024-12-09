FROM node
RUN git clone https://framagit.org/yphil/petrolette
RUN cd petrolette && npm install
EXPOSE 8000
WORKDIR /petrolette
COPY start.sh /petrolette/start.sh

ENV TZ "Europe/Paris"
ENV PATH "/usr/bin/:${PATH}"

