#!/bin/sh
gunicorn -c /home/app/gunicorn_conf.py app.main:app