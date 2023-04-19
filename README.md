# alpine-apache-php-composer

Minimal Alpine-based docker image with Apache 2, PHP 8.1, and Composer.

Note: SSL support is installed but not configured.

## Environment Variables

| Variable     | Default | Description |
| :-------     | :------ | :---------- |
| SERVER_ADMIN | you@example.com | Admin email address |
| SERVER_NAME  | automatically determined | Main name and port that server uses |
| LOG_LEVEL    | warn | debug/info/notice/warn/error/crit/alert/emerg |
| PHP_MEMORY_LIMIT | 256M | |
