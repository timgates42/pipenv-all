FROM ubuntu:18.04
ARG PYTHONVERS
ENV PYTHONVERS $PYTHONVERS
COPY install.sh /build/install.sh
RUN /build/install.sh && \
  rm -r /build
