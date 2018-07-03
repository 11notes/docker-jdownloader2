# -------------------- HEADER  -------------------- #
FROM openjdk:8-jre-alpine

# -------------------- RUN     -------------------- #
RUN mkdir -p /downloads \
    && mkdir -p /config \
    && mkdir -p /opt/jdownloader2 \
    && wget --quiet -O /opt/jdownloader2/JDownloader.jar http://installer.jdownloader.org/JDownloader.jar \
    && chmod +x /opt/jdownloader2/JDownloader.jar \
    && ln -s /config /opt/jdownloader2/cfg \
    && ln -s /downloads /root/Downloads

RUN /usr/bin/java -Xmx1024M -Djava.awt.headless=true -jar /opt/jdownloader2/JDownloader.jar

# -------------------- VOLUMES -------------------- #
VOLUME ["/downloads", "/config"]

# -------------------- CMD     -------------------- #
ENTRYPOINT ["/usr/bin/java", "-Xmx1024M", "-Djava.awt.headless=true", "-jar", "/opt/jdownloader2/JDownloader.jar"]
CMD ["start"]