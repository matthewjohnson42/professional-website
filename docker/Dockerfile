FROM nginx:1.17.9-alpine

RUN mkdir /usr/share/nginx/html/css
RUN mkdir -p /usr/share/nginx/html/docs/papers
RUN mkdir /usr/share/nginx/html/images

COPY webpage/* /usr/share/nginx/html/
COPY webpage/css/* /usr/share/nginx/html/css/
COPY webpage/docs/* /usr/share/nginx/html/docs/
COPY webpage/docs/papers/* /usr/share/nginx/html/docs/papers/
COPY webpage/images/* /usr/share/nginx/html/images/

COPY docker/professional-website.nginx.conf /etc/nginx/conf.d/professional-website.conf
