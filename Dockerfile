FROM python:3.7-slim
VOLUME /config
COPY . /
RUN \
	echo "**** install system packages ****" && \
		apt-get update && \
		apt-get upgrade -y && \
		apt-get install -y tzdata && \
	echo "**** install python packages ****" && \
		pip3 install --no-cache-dir --upgrade --requirement /requirements.txt && \
	echo "**** install Plex-Auto-Collections ****" && \
		chmod +x /app/plex_auto_collections.py && \
	echo "**** cleanup ****" && \
		apt-get autoremove -y && \
		apt-get clean && \
		rm -rf \
			/requirements.txt \
			/tmp/* \
			/var/tmp/* \
			/var/lib/apt/lists/*
WORKDIR /app
ENTRYPOINT ["python3", "plex_auto_collections.py"]