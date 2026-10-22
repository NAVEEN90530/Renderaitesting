
FROM ollama/ollama:latest

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 10000

ENTRYPOINT ["/bin/bash", "/start.sh"]
