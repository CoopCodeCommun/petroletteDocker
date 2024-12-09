FROM node
RUN git clone https://framagit.org/yphil/petrolette
RUN cd petrolette && npm install
EXPOSE 8000
WORKDIR /petrolette

ENV TZ "Europe/Paris"
ENV PATH "/usr/bin/:${PATH}"

# CMD ["npm", "start", "&&", "tail", "-f", "/dev/null"] 