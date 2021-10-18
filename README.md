# Installation
Run `./install.sh all/system/home` on a flake ready system.

# Non-declarative steps (things that must be done on a brand new system)
- Change mysql root password to "root" using `mysql_secure_installation`.
- Recreate /srv/http.
- Enable all firefox plugins for the first time.
- You'll have to type your git password at least once after pushing.
- Recreate mysql website databases.
