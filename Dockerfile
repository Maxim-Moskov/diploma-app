FROM nginx:1.27-alpine

LABEL maintainer="Maxim Moskov"
LABEL description="Тестовое приложение дипломного проекта Netology DevOps"

ARG BUILD_VERSION=dev
ARG BUILD_COMMIT=local
ARG BUILD_DATE=unknown

COPY site/index.html /usr/share/nginx/html/index.html

RUN sed -i "s|BUILD_VERSION|${BUILD_VERSION}|g; \
            s|BUILD_COMMIT|${BUILD_COMMIT}|g; \
            s|BUILD_DATE|${BUILD_DATE}|g" \
        /usr/share/nginx/html/index.html

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget -q --spider http://localhost/ || exit 1

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
