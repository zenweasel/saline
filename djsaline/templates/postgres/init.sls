postgresql:
  service.running:
    - name: postgresql
    - enabled: True
    - watch:
        - file: /etc/postgresql/9.0/main/pg_hba.conf
    - require:
      - pkg: postgresql

pg_hba.conf:
  file.managed:
    - name: /etc/postgresql/9.0/main/pg_hba.conf
    - source: salt://pg_hba.conf
    - user: postgres
    - group: postgres
    - mode: 644
    - require:
        - pkg: postgresql

postgresql.conf:
  file.managed:
   - name: /etc/postgresql/9.0/main/postgres.conf
   - source: salt://postgresql.conf
   - user: postgres
   - group: postgres
   - mode: 644
   - require:
       - pkg: postgresql

dbconfig:
    postgres_user.present:
        - name: django
        - password: django
        - createdb: True
        - runas: postgres
        - require:
            - service: postgresql

    postgres_database.present:
        - name: {{project_name}}
        - owner: pim
        - runas: postgres
        - require:
            - postgres_user: django_lot
