#!/bin/sh

echo "=========== remove previous migrations files =================="
echo ". -path "*/migrations/*.py" -not -name "__init__.py" -delete"
find . -path "*/migrations/*.py" -not -name "__init__.py" -delete
echo ". -path "*/migrations/*.pyc" -delete"
find . -path "*/migrations/*.pyc" -delete
# echo "remove database db.sqlite"
# rm db.sqlite3

echo "======================== makemigrations ========================"
#python manage.py makemigrations  
python manage.py makemigrations notifications

echo "================= migrate ====================================="
echo "==============================================================="
python manage.py migrate
echo "done ."
echo "==============================================================="
echo "================= collect static files ========================"
python manage.py collectstatic --noinput
echo "done ."
echo "=================running app==================================="
#daphne -b 0.0.0.0 -p 8000 app.asgi:application
python manage.py runserver 0.0.0.0:8085 &
python manage.py consumer &

# Optionally, print the process IDs (PIDs) for reference
echo "Django server PID: $!"
echo "RabbitMQ consumer PID: $!"
# Wait for both processes to finish
wait

