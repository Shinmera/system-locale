## About System-Locale
This library retrieves locale information configured on the system. This is helpful if you want to write applications and libraries that display messages in the user's native language.

## How To
Primarily you'll want to use the functions `locale` and `language` to retrieve the information. You can also `setf` them if you want to force a particular setting.

    (system-locale:locale)   ; => "en_GB.UTF-8"
    (system-locale:language) ; => "en"

The functions `discover-active-locales` and `discover-active-languages` describe how the locale and language discovery is handled.
