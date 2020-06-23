<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

require_once 'vendor/autoload.php';

$dotenv = new Dotenv\Dotenv(__DIR__);
$dotenv->load(); 

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', $_ENV['DB']);

/** MySQL database username */
define('DB_USER', 'root');

/** MySQL database password */
define('DB_PASSWORD', $_ENV['DB_ROOT_PASSWORD']);

/** MySQL hostname */
define('DB_HOST', 'db');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8mb4');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '3NXV=hEhm$RXJ0lKk$b1@^|6!}Bf1?%O-Pu{tK}v$aS$;g;il[?Z(Q%<q:im$^cj');
define('SECURE_AUTH_KEY',  'b`~a0}TLmYl+ky1Q8v{KQ|M=SnN2 7Cj-YR,j}kRBU8##m1f~ZsAMg>c,Xv-K(YV');
define('LOGGED_IN_KEY',    '@_r?FGP@j!-iItcba(2_Q$+g25DrpB<NiV9UfCIkF9@Jsc9+g-ngI+GM3u]y$=F0');
define('NONCE_KEY',        'bp#e4j*y| )|R5B}tRCElidY+swsZpXjaK5Dz57Q>eApPOk.u>KF:lk{A;@4yF9!');
define('AUTH_SALT',        'dZ7&+%-}(-5@s+8wE!DTx,.m6/JaPIQ,$V{`}nt-nP%TR[;FfCho@!?kp&pwT/r-');
define('SECURE_AUTH_SALT', 'x0hx$1ZKhgVT|!*-pxbeVvV=zj4gf=y!+109utJ+(`!5zxz99ed_I5&*{Fx[zx:!');
define('LOGGED_IN_SALT',   '9|E$~|~4UtAKND%+3w=yF!@6e+GF@a=^$8{P^,87OqQ2Wk%2w-_z{vj@1J7fh?+p');
define('NONCE_SALT',       'jrNy?<`FH82l7eLEm!g{9Ew(8Nz|r679HXt4sw,K._;m_OnFvOI^)G)[N/|hNc(}');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'av_';

define('WP_POST_REVISIONS', 3);

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define('WP_DEBUG', true);

/* That's all, stop editing! Happy blogging. */

/* Change wp-content folder. */
//define('WP_CONTENT_DIR',    __DIR__ . '/wp-content');
//define('WP_CONTENT_URL',    '/wp-content');

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/wordpress');

/* Change wp-content folder. */
define ('WP_CONTENT_FOLDERNAME', '../wp-content');
define ('WP_CONTENT_DIR', ABSPATH . WP_CONTENT_FOLDERNAME) ;
define ('WP_CONTENT_URL', '/wp-content');	


define('WP_SITEURL',    $_ENV['HOST'].'/wordpress');
define('WP_HOME',       $_ENV['HOST']);

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');

//define( 'UPLOADS', './wp-content/uploads' );
