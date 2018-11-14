# ------ Header ------ #
FROM openjdk:8-jre-alpine

# ------ VOLUMES ------ #
VOLUME ["/downloads", "/config"]

# ------ RUN  ------ #
RUN mkdir -p /config \
    && mkdir -p /downloads \
    && mkdir -p /usr/local/lib/jd \
    && ln -s /downloads /root/Downloads \
    && ln -s /usr/local/lib/jd/cfg /config \
    && wget --quiet -O /usr/local/lib/jd/JDownloader.jar http://installer.jdownloader.org/JDownloader.jar \
    && chmod +x /usr/local/lib/jd/JDownloader.jar \
    && /usr/bin/java -Djava.awt.headless=true -jar /usr/local/lib/jd/JDownloader.jar

# ------ CMD/START/STOP ------ #
ENTRYPOINT ["/usr/bin/java", "-Djava.awt.headless=true", "-jar", "/usr/local/lib/jd/JDownloader.jar"]
CMD ["start"]