#|
 This file is a part of system-locale
 (c) 2018 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.system-locale)

(docs:define-docs
  (variable *fallback-locale*
    "The default fallback locale used if no system locale can be discovered.

This is, by default, en_US.UTF-8.

See LOCALE")

  (variable *locales*
    "The list of user-preferred locales, with the most preferred first.

This list is empty if no user-preferences could be found.
This variable is unbound if LOCALES has not yet been called.

See LOCALES
See LOCALE")

  (variable *languages*
    "The list of user-preferred languages, with the most preferred first.

This list is empty if no user-preferences could be found.
This variable is unbound if LANGUAGES has not yet been called.

See LANGUAGES
See LANGUAGE")

  (function locale-language
    "Returns the language-code part of a locale.

  \"en_US.UTF-8\" => \"en\"
  \"en_US\"       => \"en\"
  \"en.UTF-8\"    => \"en\"
  \"en\"          => \"en\"
  \"_US.UTF-8\"   => NIL
  \"_US\"         => NIL
  \".UTF-8\"      => NIL")

  (function locale-region
    "Returns the language region-code part of a locale.

  \"en_US.UTF-8\" => \"US\"
  \"en_US\"       => \"US\"
  \"en.UTF-8\"    => NIL
  \"en\"          => NIL
  \"_US.UTF-8\"   => \"US\"
  \"_US\"         => \"US\"
  \".UTF-8\"      => NIL")

  (function locale-charset
    "Returns the charset-code part of a locale.

  \"en_US.UTF-8\" => \"UTF-8\"
  \"en_US\"       => NIL
  \"en.UTF-8\"    => \"UTF-8\"
  \"en\"          => NIL
  \"_US.UTF-8\"   => \"UTF-8\"
  \"_US\"         => NIL
  \".UTF-8\"      => \"UTF-8")

  (function locale-equal
    "Returns true if the two locales are equal.

Equal means that all the locale parts that are
given in both locales match.

  \"en\" \"en_US\"  => T
  \"en_GB\" \"_US\" => NIL
  etc.")

  (function discover-active-locales
    "Attempts to discover user-preferred system locales.

Returns a list of found locales.
It considers the following environment variables:

- LC_ALL
- LC_MESSAGES
- LANG

On Windows, it also considers the following WINAPI calls:

- GetUserDefaultLocaleName
- GetSystemDefaultLocaleName

See LOCALES")

  (function locales
    "Accessor to the list of user-preferred locales.

This may be NIL if no preferred locales have been found.
If REDISCOVER is non-NIL, DISCOVER-ACTIVE-LOCALES is
always called. Otherwise, if the *LOCALES* variable is
bound, its value is returned instead.

See *LOCALES*
See DISCOVER-ACTIVE-LOCALES")

  (function locale
    "Accessor to the user-preferred locale.

This returns the first matching item returned by LOCALES,
or *FALLBACK-LOCALE* if no match by LOCALE-EQUAL is found.

If the fallback locale was returned, the secondary value
is :FALLBACK.

Setting this place will add the given locale to the
*LOCALES* list if it is not yet present, and otherwise
move it to the front of the list.

See LOCALE-EQUAL
See LOCALES
See *FALLBACK-LOCALE*")

  (function discover-active-languages
    "Attempts to discover user-preferred system languages.

Returns a list of found language codes.
It considers the following environment variables:

- LANGUAGE

In addition it will extract the language code from all
locales returned by DISCOVER-ACTIVE-LOCALES.

See DISCOVER-ACTIVE-LOCALES
See LANGUAGES")

  (function languages
    "Accessor to the list of user-preferred languages.

This may be NIL if no preferred languages have been found.
If REDISCOVER is non-NIL, DISCOVER-ACTIVE-LANGUAGES is
always called. Otherwise, if the *LANGUAGES* variable is
bound, its value is returned instead.

See *LANGUAGES*
See DISCOVER-ACTIVE-LANGUAGES")

  (function language
    "Accessor to the user-preferred language.

This returns the first matching item returned by LANGUAGES,
or the language-code part of *FALLBACK-LOCALE* if no match
by STRING-EQUAL is found.

If the fallback language was returned, the secondary value
is :FALLBACK.

Setting this place will add the given language to the
*LANGUAGES* list if it is not yet present, and otherwise
move it to the front of the list.

See LANGUAGES
See *FALLBACK-LOCALE*"))
