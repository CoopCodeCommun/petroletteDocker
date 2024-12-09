FROM node
RUN git clone https://framagit.org/yphil/petrolette
RUN cd petrolette && npm install
EXPOSE 8001
WORKDIR /petrolette

ENV TZ "Europe/Paris"
ENV PATH "/usr/bin/:${PATH}"

ENV NODE_ENV "production"
CMD ["node", "./http/server.js"] 