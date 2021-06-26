---
{% for user, args in pillar.get('users', {}).items() %}

# CREATE USER ACCOUNT
# For each item in the users pillar, a MySQL account will be created with appropriate grants.  Each user will be granted
# permissions for databases which begin their name and an underscore.  If the user is marked as an admin, they will be
# granted permissions on all databases.
{{ user }}:
  mysql_user.present:
    - host: "{{ args.host }}"
    - password: {{ args.password }}
  mysql_grants.present:
    - grant: all privileges
    {% if args.is_admin %}
    - database: "*.*"
    {% else %}
    - database: {{ user }}_%.*
    {% endif %}
    - user: {{ user }}
    - host: "{{ args.host }}"

{% if args.databases is defined %}
{% for database in args.databases %}

# CREATE USER'S DATABASES
# A database will be created for each item in the databases list for this user.  This will take the format of
# name_database.
{{ user }}_{{ database }}:
  mysql_database.present

{% endfor %}
{% endif %}

{% endfor %}
