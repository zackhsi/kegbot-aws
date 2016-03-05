{% set venv = '/data/kb' %}
{% set repo = '/srv/repos/kegbot-aws' %}

{% for package in [
  'libjpeg-dev',
  'libmysqlclient-dev',
  'libpq-dev',
  'mysql-client',
  'mysql-server',
  'nginx',
  'postgresql',
  'postgresql-contrib',
  'python-dev',
  'python-pip',
  'python-psycopg2',
  'redis-server',
  'supervisor',
] %}
Ensure {{ package }} package is installed:
  pkg.installed:
    - name: {{ package }}
{% endfor %}

Ensure virtualenv is installed:
  pip.installed:
    - name: virtualenv

Ensure virtualenv is managed:
  virtualenv.managed:
    - name: {{ venv }}
    - requirements: salt://kegbot/requirements.txt

Mount EBS for static files:
  mount.mounted:
    - name: /srv/kegbot-data
    - fstype: ext4
    - device: /dev/xvdf
    - mkmnt: True

Collect static files in mount:
  cmd.run:
    - name: {{ venv }}/bin/kegbot collectstatic -v3 --noinput
    - unless: "[[ $(ls -A /srv/kegbot-data) ]]"

Ensure kegbot configuration:
  file.managed:
    - name: /home/ubuntu/.kegbot/local_settings.py
    - source: salt://kegbot/local_settings.sls
    - template: jinja
    - makedirs: True
    - mode: 644
    - user: ubuntu
    - group: ubuntu

Ensure kegbot service script:
  file.managed:
    - name: /etc/init/kegbot-server.conf
    - source: salt://kegbot/kegbot-server.conf
    - template: jinja
    - mode: 644
    - listen_in:
      - service: kegbot-server

Run kegbot server:
  service.running:
    - name: kegbot-server
