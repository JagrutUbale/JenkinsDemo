#Base Image 
FROM node:8.4.0 as stag1
WORKDIR /app/
COPY . /app/

#CMD ["node", "index.js"]

#EXPOSE 8080


#Minized Size Image Original Size 300MB
#FROM node:8-slim #146 MB
#FROM node:8-alpine # 80MB

FROM node:8-alpine
WORKDIR /app/
COPY --from=stag1 /app /app/
CMD ["node", "index.js"]
EXPOSE 8080
