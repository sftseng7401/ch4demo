# local 端的 file structure 如下
# ----------------------------------------------------
#└── simple_flask
#    ├── Dockerfile
#    ├── myapp
#    │   ├── app.py
#    │   └── templates
#    │       └── index.html
#    └── requirements.txt

# Base image 是 python:3.7
FROM python:3.7

RUN mkdir /app

# requirements.txt 裡有我們需要的套件資訊
# 把本地端的 requirement 複製到 container中
COPY ./requirements.txt /app/requirements.txt

# # 切換到container裡的 /app 路徑作為工作目錄 
WORKDIR /app

# pip是python的套件管理工具
RUN pip install -r requirements.txt

# # 把本地端myapp資料夾複製到container的當前目錄 (/app)
ADD ./myapp .

# 5000是我們服務所在的port
EXPOSE 5000

# 在系統中加入一個新system user 和 group，名稱皆為appuser
RUN adduser --system --group --no-create-home appuser

# 把 /app 這個directory的擁有權指定給appuser
RUN chown appuser:appuser -R --verbose /app

# 把container的 user 轉到appuser
USER appuser
# CMD代表command，當你啟動這個container時，會預設執行這個指令
CMD ["python3","/app/app.py"]

################################################################################################################################################################

# FROM alpine:3.9 AS compile-image

# # Add requirements for python and pip
# RUN apk add --update python3

# RUN mkdir -p /opt/code
# WORKDIR /opt/code

# # Install dependencies
# RUN apk add python3-dev build-base gcc linux-headers postgresql-dev libffi-dev

# # # Create a virtual environment for all the Python dependencies
# # RUN python3 -m venv /opt/venv
# # # Make sure we use the virtualenv:
# # ENV PATH="/opt/venv/bin:$PATH"
# RUN pip3 install --upgrade pip


# # Install other dependencies
# COPY ./requirements.txt /opt/
# RUN pip3 install -r /opt/requirements.txt

# ########
# # This image is the runtime, will copy the dependencies from the other
# ########
# FROM alpine:3.9 AS runtime-image

# # Install python
# RUN apk add --update python3 curl libffi postgresql-libs
# # Copy uWSGI configuration
# # RUN mkdir -p /opt/uwsgi
# # ADD docker/app/uwsgi.ini /opt/uwsgi/
# # ADD docker/app/start_server.sh /opt/uwsgi/



# # # Create a user to run the service
# # RUN addgroup -S uwsgi
# # RUN adduser -H -D -S uwsgi
# # USER uwsgi

# # # Copy the venv with compile dependencies from the compile-image
# # COPY --chown=uwsgi:uwsgi --from=compile-image /opt/venv /opt/venv
# # # Be sure to activate the venv
# # ENV PATH="/opt/venv/bin:$PATH"

# # Copy the code
# # COPY --chown=uwsgi:uwsgi ThoughtsBackend/ /opt/code/

# ADD ./myapp /opt/code

# # 在系統中加入一個新system user 和 group，名稱皆為appuser
# RUN adduser --system --group --no-create-home appuser

# # 把 /app 這個directory的擁有權指定給appuser
# RUN chown appuser:appuser -R --verbose /app

# # 把container的 user 轉到appuser
# USER appuser
# # CMD代表command，當你啟動這個container時，會預設執行這個指令
# EXPOSE 5000
# CMD ["python3","/opt/code/app.py"]

# # Run parameters
# # WORKDIR /opt/code
# # CMD ["/bin/sh", "/opt/code/app.py"]
