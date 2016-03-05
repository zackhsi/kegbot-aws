# NEVER set DEBUG to `True` in production.
DEBUG = True
TEMPLATE_DEBUG = DEBUG

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'kegbot',
        'USER': '{{ salt["pillar.get"]("db:user") }}',
        'PASSWORD': '{{ salt["pillar.get"]("db:password") }}',
        'HOST': '{{ salt["pillar.get"]("db:host") }}',
    }
}

KEGBOT_ROOT = '/srv/kegbot-data'
MEDIA_ROOT = '/srv/kegbot-data/media'
STATIC_ROOT = '/srv/kegbot-data/static'

EMAIL_BACKEND =  'postmark.django_backend.EmailBackend'
EMAIL_FROM_ADDRESS = '{{ salt["pillar.get"]("email_from_address") }}'

SECRET_KEY = '{{ salt["pillar.get"]("secret_key") }}'
