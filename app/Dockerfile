FROM ubuntu:20.04
ARG PYTHONVERS
ENV PYTHONVERS $PYTHONVERS
COPY install.sh /build/install.sh
RUN /build/install.sh && \
  rm -r /build
WORKDIR /workspace
ENV HOME /workspace
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
